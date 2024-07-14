import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color borderColor = AppPallete.borderColor]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: borderColor,
          width: 3,
        ),
      );

  static final darkThemeMode = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.transparentColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(
        AppPallete.gradient2,
      ),
    ),
  );
}
