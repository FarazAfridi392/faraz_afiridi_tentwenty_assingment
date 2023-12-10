import 'package:flutter/material.dart';

Color primary = const Color(0xFF61C3F2);

ThemeData light = ThemeData(
  appBarTheme:
      const AppBarTheme(backgroundColor: Color(0xFFFFFFFF), elevation: 1),
  fontFamily: 'Poppins',
  primaryColor: primary,
  scaffoldBackgroundColor: const Color(0xFFF2F2F6),
  secondaryHeaderColor: primary,
  disabledColor: const Color(0xFFBABFC4),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  // cardColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: primary,
    secondary: primary,
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary)),
);
