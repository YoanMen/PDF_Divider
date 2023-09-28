// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class Pdf {
  final String name;
  final String path;

  const Pdf({required this.name, required this.path});

  @override
  bool operator ==(covariant Pdf other) {
    if (identical(this, other)) return true;

    return other.name == name && other.path == path;
  }

  @override
  int get hashCode => name.hashCode ^ path.hashCode;

  @override
  String toString() => 'Pdf(name: $name, path: $path)';
}
