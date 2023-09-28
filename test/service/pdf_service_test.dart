import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_splitter/domain/entities/pdf.dart';
import 'package:pdf_splitter/service/pdf_service.dart';

void main() {
  group('PdfService Tests', () {
    late PdfService pdfService;
    late Directory tempDir;

    setUp(() async {
      pdfService = PdfService();
      tempDir = await Directory.systemTemp.createTemp('pdf_test');
    });

    tearDown(() async {
      await tempDir.delete(recursive: true);
    });

    test('loadPdfDropIn should convert XFiles to Pdf entities', () async {
      List<XFile> mockXFiles = [
        XFile('${tempDir.path}/file1.pdf'),
        XFile('${tempDir.path}/file2.txt'),
        XFile('${tempDir.path}/file3.pdf'),
      ];

      List<Pdf> result = await pdfService.loadPdfDropIn(mockXFiles);

      expect(result.length, 2);
      expect(result[0].name, 'file1.pdf');
      expect(result[1].name, 'file3.pdf');
    });

    test('loadPdfDropIn with empty list', () async {
      List<XFile> mockXFiles = [];

      List<Pdf> result = await pdfService.loadPdfDropIn(mockXFiles);

      expect(result, []);
    });

    test('dividePdf with successful split', () async {
      const testPdf =
          Pdf(name: 'test.pdf', path: '/home/USER/Documents/test.pdf');
      final result = await pdfService.dividePdf([testPdf]);

      expect(result.isSuccess(), true);
    });
  });
}
