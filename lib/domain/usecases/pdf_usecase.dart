import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:pdf_splitter/core/common/failure.dart';
import 'package:pdf_splitter/service/pdf_service.dart';
import 'package:pdf_splitter/domain/entities/pdf.dart';

final pdfUseCaseProvider = Provider<PdfUseCase>((ref) {
  return PdfUseCase(ref.read(pdfServiceProvider));
});

class PdfUseCase {
  PdfUseCase(this._pdfService);
  final PdfService _pdfService;

  Future<Result<List<Pdf>, Failure>> loadPdfDropIn(
      DropDoneDetails files) async {
    try {
      final response = await _pdfService.loadPdfDropIn(files.files);

      return Success(response);
    } catch (e) {
      throw Failure(message: "Something went wrong $e");
    }
  }

  Future<Result<List<Pdf>, Failure>> loadPdfFilesPicker() async {
    try {
      final response = await _pdfService.loadPdfFilesPicker();

      return Success(response);
    } catch (e) {
      throw Failure(message: "Something went wrong $e");
    }
  }

  Future<Result> dividePdf(List<Pdf> pdfs) async {
    try {
      await _pdfService.dividePdf(pdfs);

      return const Success(Success);
    } catch (error) {
      return Error(error.toString());
    }
  }
}
