import 'package:flutter/material.dart';

import 'colours.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    hintColor: AppColors.accentColor,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    // Define other light theme properties here
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightTextColor),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    hintColor: AppColors.accentColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    // Define other dark theme properties here
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextColor),
    ),
  );
}
