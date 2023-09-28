import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_splitter/presentation/screen/divider_screen.dart';
import 'package:pdf_splitter/theme/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DesktopWindow.setWindowSize(const Size(120, 160));

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.whiteTheme(context),
      darkTheme: CustomTheme.blackTheme(context),
      debugShowCheckedModeBanner: false,
      home: const DividerScreen(),
    );
  }
}
