import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:pdf_splitter/core/common/failure.dart';
import 'package:pdf_splitter/data/models/pdf_feitching.dart';
import 'package:pdf_splitter/domain/entities/pdf.dart';
import 'dart:io';

final pdfServiceProvider = Provider<PdfService>((ref) {
  return PdfService();
});

class PdfService {
  Future<List<Pdf>> loadPdfDropIn(List<XFile> files) async {
    List<PdfFeitching> pdfs = [];

    for (var file in files) {
      if (file.path.endsWith("pdf")) {
        pdfs.add(PdfFeitching(name: file.name, path: file.path));
      }
    }
    return pdfs.map((e) => e.toEntity()).toList();
  }

  Future<List<Pdf>> loadPdfFilesPicker() async {
    List<Pdf> pdfs = [];

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.paths.isNotEmpty) {
      List<XFile> filesList = result.paths.map((path) => XFile(path!)).toList();
      for (var file in filesList) {
        pdfs.add(Pdf(name: file.name, path: file.path));
      }
    }

    return pdfs;
  }

  Future<Result> dividePdf(List<Pdf> pdfs) async {
    try {
      var havePDFTK = Platform.isLinux
          ? await Process.run('pdftk', ['--version'])
          : await Process.run(
              "C:/Program Files (x86)/PDFtk Server/bin/pdftk.exe",
              ['--version'],
              runInShell: true);

      if (pdfs.isNotEmpty && havePDFTK.exitCode == 0) {
        for (var pdf in pdfs) {
          String outpath = pdf.path.replaceAll(pdf.name, "");
          outpath = outpath.replaceAll(".pdf", "");

          String outFolderPath = pdf.path.replaceAll(pdf.name, "");
          outFolderPath = outFolderPath.replaceAll(".pdf", "");

          await Directory(
                  "$outFolderPath/${pdf.name.replaceAll(".pdf", "")}_pages")
              .create(recursive: true);

          final result = Platform.isLinux
              ? await Process.run(
                  'pdftk',
                  [
                    pdf.path,
                    'burst',
                    'output',
                    '$outFolderPath/${pdf.name.replaceAll(".pdf", "")}_pages/${pdf.name.replaceAll(".pdf", "")}_%02d.pdf'
                  ],
                )
              : await Process.run(
                  "C:/Program Files (x86)/PDFtk Server/bin/pdftk.exe",
                  [
                    pdf.path,
                    'burst',
                    'output',
                    '$outFolderPath/${pdf.name.replaceAll(".pdf", "")}_pages/${pdf.name.replaceAll(".pdf", "")}_%02d.pdf'
                  ],
                  runInShell: true);

          if (result.exitCode != 0) {
            throw Failure(message: 'Error splitting PDF: ${result.stderr}');
          }
        }
      }
    } catch (e) {
      throw Failure(message: "error : $e");
    }
    return const Success(Success);
  }
}
