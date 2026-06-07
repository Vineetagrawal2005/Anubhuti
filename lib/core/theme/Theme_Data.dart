import 'package:flutter/material.dart';

ThemeData lightMode(Color primaryColor) => ThemeData(
  brightness: Brightness.light,
  textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: primaryColor,
    secondary: Colors.black,
  ),
);

ThemeData darkMode(Color primaryColor) => ThemeData(
  brightness: Brightness.dark,
  textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: primaryColor,
    secondary: Colors.white,
  ),
);
