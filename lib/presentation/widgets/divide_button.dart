import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_splitter/presentation/viewmodel/pdf_view_model.dart';

class DivideButton extends ConsumerWidget {
  const DivideButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ElevatedButton(
            onPressed: () => ref.read(pdfViewModel.notifier).dividePdf(context),
            child: const Text("Divide")),
      ),
    );
  }
}
