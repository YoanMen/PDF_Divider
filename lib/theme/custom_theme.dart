import 'package:flutter/material.dart';
import 'package:pdf_splitter/theme/palette.dart';

class CustomTheme {
  static ThemeData whiteTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.black,
            showCloseIcon: true,
            closeIconColor: Colors.white),
        colorScheme: colorScheme,
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: const AppBarTheme(
            elevation: 0, backgroundColor: Colors.transparent));
  }

  static ThemeData blackTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
        snackBarTheme: const SnackBarThemeData(
            showCloseIcon: true, closeIconColor: Colors.white),
        colorScheme: colorScheme,
        scaffoldBackgroundColor: blackColor,
        textTheme: theme.textTheme
            .apply(bodyColor: whiteColor, displayColor: whiteColor),
        appBarTheme: const AppBarTheme(
            elevation: 0, backgroundColor: Colors.transparent));
  }
}
