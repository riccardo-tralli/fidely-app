import 'package:fidely_app/misc/themes/fonts.dart';
import 'package:fidely_app/misc/themes/rradius.dart';
import 'package:flutter/material.dart';

class DarkTheme {
  static final Color primaryColor = Color.fromARGB(255, 255, 173, 51);
  static const Color secondaryColor = Color.fromARGB(255, 36, 123, 194);

  static final Color backgroundColor = Colors.grey.shade900;
  static final Color onBackgroundColor = Colors.grey.shade700;
  static final Color surfaceColor = Colors.grey.shade900;
  static final Color onSurfaceColor = Colors.grey.shade300;

  static final Color snackBarColor = Colors.grey.shade800;
  static final Color snackBarTextColor = Colors.white;

  static final Color inputSurfaceColor = Colors.grey.shade800;
  static final Color inputBorderColor = Colors.grey.shade700;

  static final Color textColor = Colors.grey.shade300;
  static final Color errorColor = Colors.red.shade300;

  static final double textInitialSize = 16;

  static ThemeData make() => ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      onSurface: onSurfaceColor,
      outline: onBackgroundColor,
      shadow: Colors.black.withAlpha(150),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: textColor,
        fontFamily: Fonts.epilogue,
        fontSize: textInitialSize * 1.2,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontFamily: Fonts.epilogue,
        fontSize: textInitialSize,
      ),
      bodySmall: TextStyle(
        color: textColor,
        fontFamily: Fonts.epilogue,
        fontSize: textInitialSize * 0.8,
      ),
      titleLarge: TextStyle(
        color: textColor,
        fontFamily: Fonts.leckerliOne,
        fontSize: textInitialSize * 2.5,
      ),
      titleMedium: TextStyle(
        color: textColor,
        fontFamily: Fonts.leckerliOne,
        fontSize: textInitialSize * 1.8,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: textColor,
        fontFamily: Fonts.leckerliOne,
        fontSize: textInitialSize * 1.6,
      ),
    ),
    iconTheme: IconThemeData(color: textColor, size: textInitialSize),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputSurfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RRadius.medium),
        borderSide: BorderSide(color: inputBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RRadius.medium),
        borderSide: BorderSide(color: inputBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RRadius.medium),
        borderSide: BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RRadius.medium),
        borderSide: BorderSide(color: errorColor),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(0, 48)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RRadius.medium),
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: surfaceColor,
            fontFamily: Fonts.epilogue,
            fontSize: textInitialSize,
          ),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: snackBarColor,
      contentTextStyle: TextStyle(color: snackBarTextColor, fontSize: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(RRadius.medium),
          topRight: Radius.circular(RRadius.medium),
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
