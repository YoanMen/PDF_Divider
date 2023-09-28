// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pdf_splitter/domain/entities/pdf.dart';

class PdfFeitching {
  final String name;
  final String path;

  PdfFeitching({required this.name, required this.path});

  Pdf toEntity() {
    return Pdf(name: name, path: path);
  }

  @override
  String toString() => 'PdfFeitching(name: $name, path: $path)';

  @override
  bool operator ==(covariant PdfFeitching other) {
    if (identical(this, other)) return true;

    return other.name == name && other.path == path;
  }

  @override
  int get hashCode => name.hashCode ^ path.hashCode;
}
