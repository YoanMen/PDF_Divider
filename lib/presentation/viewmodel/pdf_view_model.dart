import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_splitter/core/common/failure.dart';
import 'package:pdf_splitter/core/common/show_snack_bar.dart';
import 'package:pdf_splitter/domain/usecases/pdf_usecase.dart';
import 'package:pdf_splitter/presentation/viewmodel/pdf_state.dart';

final pdfViewModel = StateNotifierProvider<PdfViewModel, PdfState>((ref) {
  return PdfViewModel(
      PdfState(pdfs: const AsyncValue.data([])), ref.read(pdfUseCaseProvider));
});

class PdfViewModel extends StateNotifier<PdfState> {
  PdfViewModel(PdfState state, this._pdfUseCase) : super(state);

  final PdfUseCase _pdfUseCase;

  void draggin(bool draggin) {
    state = state.copyWith(draggin: draggin);
  }

  void loadPdfFilesPicker() async {
    state = state.copyWith(isLoading: true, pdfs: const AsyncData([]));

    final response = await _pdfUseCase.loadPdfFilesPicker();

    response.when((success) {
      state = state.copyWith(isLoading: false, pdfs: AsyncData(success));
    }, (error) {
      Failure(message: error.message);
    });

    state = state.copyWith(isLoading: false);
  }

  void loadPdfDropIn(DropDoneDetails files) async {
    state = state.copyWith(isLoading: true, pdfs: const AsyncValue.loading());

    if (state.pdfs.value!.isNotEmpty) {
      const Duration(milliseconds: 3000);
    }

    final response = await _pdfUseCase.loadPdfDropIn(files);

    response.when((success) {
      state = state.copyWith(isLoading: false, pdfs: AsyncData(success));
    }, (error) {
      Failure(message: error.message);
    });
    state = state.copyWith(isLoading: false);
  }

  void resetDropIn() async {
    state = state.copyWith(pdfs: const AsyncValue.data([]));
  }

  void dividePdf(BuildContext context) async {
    var pdfList = state.pdfs.value;

    if (pdfList!.isNotEmpty && !state.isLoading) {
      state = state.copyWith(isLoading: true);

      final response = await _pdfUseCase.dividePdf(pdfList);

      response.when((success) {
        showSnackBar(
            context: context,
            message: "${state.pdfs.value!.length} PDF divided");
      }, (error) {
        showSnackBar(context: context, message: error);

        Failure(message: error.message);
        state = state.copyWith(isLoading: false);
      });
    }
    state = state.copyWith(isLoading: false);
  }
}
