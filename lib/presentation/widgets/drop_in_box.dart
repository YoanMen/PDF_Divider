import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_splitter/presentation/viewmodel/pdf_view_model.dart';
import 'package:pdf_splitter/presentation/widgets/close_icon.dart';
import 'package:pdf_splitter/theme/palette.dart';

class DropInBox extends ConsumerWidget {
  const DropInBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 180,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: DropTarget(
              onDragDone: (urls) {
                ref.read(pdfViewModel.notifier).loadPdfDropIn(urls);
              },
              onDragEntered: (urls) {
                ref.read(pdfViewModel.notifier).draggin(true);
              },
              onDragExited: (detail) {
                ref.read(pdfViewModel.notifier).draggin(false);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: ref.watch(pdfViewModel).draggin
                          ? redColor.withOpacity(0.40)
                          : redColor.withOpacity(0.10),
                    )),
                height: 150,
                width: 120,
                child: ref.read(pdfViewModel).pdfs.value!.isEmpty
                    ? Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: ref.watch(pdfViewModel).isLoading
                              ? () {}
                              : () => ref
                                  .read(pdfViewModel.notifier)
                                  .loadPdfFilesPicker(),
                          icon: const Icon(
                            Icons.add_circle,
                          ),
                          color: redColor,
                        ))
                    : (ref.read(pdfViewModel).pdfs.value!.length == 1)
                        ? Image.asset(
                            fit: BoxFit.cover,
                            "assets/pdf.png",
                          )
                        : Image.asset(
                            fit: BoxFit.cover,
                            "assets/multiple_pdf.png",
                          ),
              ),
            ),
          ),
          ref.read(pdfViewModel).pdfs.value!.isNotEmpty
              ? Positioned(
                  left: 50,
                  top: 10,
                  child: CloseIcon(
                    onTap: () => ref.read(pdfViewModel.notifier).resetDropIn(),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
