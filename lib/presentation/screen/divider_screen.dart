import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_splitter/presentation/viewmodel/pdf_view_model.dart';
import 'package:pdf_splitter/presentation/widgets/drop_in_box.dart';
import 'package:pdf_splitter/presentation/widgets/progress_bar_indicator.dart';
import 'package:pdf_splitter/presentation/widgets/divide_button.dart';

class DividerScreen extends ConsumerWidget {
  const DividerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            const ProgressBarIndicator(),
            Opacity(
              opacity: ref.watch(pdfViewModel).isLoading ? 0.5 : 1,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropInBox(),
                  Spacer(),
                  DivideButton(),
                  SizedBox(
                    height: 6,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Opacity(
                        opacity: 0.5,
                        child: Text(
                          "ver. 0.0.1",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
