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
      labelLarge: TextStyle(color: AppColors.lightButtonTextColor), // Button text style
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.lightButtonTextColor, // Text color for buttons
        backgroundColor: AppColors.primaryColor, // Background color for buttons
      ),
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
      labelLarge: TextStyle(color: AppColors.darkButtonTextColor), // Button text style
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.darkButtonTextColor, // Text color for buttons
        backgroundColor: AppColors.primaryColor, // Background color for buttons
      ),
    ),
  );
}
