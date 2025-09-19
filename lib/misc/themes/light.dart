import 'package:flutter/material.dart';

class LightTheme {
  static final primaryColor = Colors.orange;
  static final secondaryColor = Colors.lightGreen.shade100;
  static final backgroundColor = Colors.grey.shade100;
  static final onBackgroundColor = Colors.grey.shade200;
  static final surfaceColor = Colors.white;
  static final onSurfaceColor = Colors.black87;
  static final snackBarColor = Colors.grey.shade800;
  static final snackBarTextColor = Colors.white;

  static final textColor = Colors.black;
  static final errorColor = Colors.red.shade300;

  static ThemeData make() => ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      onSurface: onSurfaceColor,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: textColor),
      bodyMedium: TextStyle(color: textColor),
      bodySmall: TextStyle(color: textColor),
      titleLarge: TextStyle(color: textColor),
      titleMedium: TextStyle(color: textColor),
      titleSmall: TextStyle(color: textColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: onBackgroundColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: onBackgroundColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: errorColor),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(0, 48)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: snackBarColor,
      contentTextStyle: TextStyle(color: snackBarTextColor, fontSize: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
  );
}
