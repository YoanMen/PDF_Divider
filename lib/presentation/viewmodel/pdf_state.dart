// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdf_splitter/domain/entities/pdf.dart';

class PdfState {
  final AsyncValue<List<Pdf>> pdfs;
  final bool draggin;
  final bool isLoading;

  PdfState({this.draggin = false, this.isLoading = false, required this.pdfs});

  PdfState copyWith({
    AsyncValue<List<Pdf>>? pdfs,
    bool? draggin,
    bool? isLoading,
  }) {
    return PdfState(
      pdfs: pdfs ?? this.pdfs,
      draggin: draggin ?? this.draggin,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
