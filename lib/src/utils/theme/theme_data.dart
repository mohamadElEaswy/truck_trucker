import 'package:flutter/material.dart';

class AppThemeData{

  static ThemeData? defaultTheme = ThemeData(
    primarySwatch: Colors.indigo,
  );

  static ThemeData? darkTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.indigo,
    brightness: Brightness.dark,
  );
}