import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_splitter/presentation/viewmodel/pdf_view_model.dart';

class ProgressBarIndicator extends ConsumerWidget {
  const ProgressBarIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(pdfViewModel).isLoading
        ? const SizedBox(child: LinearProgressIndicator())
        : const SizedBox.shrink();
  }
}
