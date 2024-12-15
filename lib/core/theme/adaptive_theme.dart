import 'package:flutter/material.dart';

// sets theme mode to dark
// AdaptiveTheme.of(context).setDark();

// sets theme mode to light
// AdaptiveTheme.of(context).setLight();

// sets theme mode to system default
// AdaptiveTheme.of(context).setSystem();

class AppThemes {
  // Light Theme Color Palette
  static const Color airForceBlue = Color(0xFF00308F);

  // Primary color for the app in light mode
  static const Color _lightPrimaryColor = airForceBlue;

  // Color used for text or icons on the primary color in light mode
  static const Color _lightOnPrimaryColor = Colors.white;

  // AppBar background color in light mode
  static const Color _lightAppBarBackgroundColor = airForceBlue;

  // AppBar text and icon color in light mode
  static const Color _lightAppBarForegroundColor = Colors.white;

  // FloatingActionButton background color in light mode
  static const Color _lightFABBackgroundColor = Colors.blue;

  // FloatingActionButton icon color in light mode
  static const Color _lightFABForegroundColor = Colors.white;

  // ElevatedButton background color in light mode
  static const Color _lightButtonBackgroundColor = airForceBlue;

  // ElevatedButton text color in light mode
  static const Color _lightButtonForegroundColor = Colors.white;

  // Dark Theme Color Palette

  // Primary color for the app in dark mode
  static const Color _darkPrimaryColor = Colors.blueAccent;

  // Color used for text or icons on the primary color in dark mode
  static const Color _darkOnPrimaryColor = Colors.black;

  // AppBar background color in dark mode
  static const Color _darkAppBarBackgroundColor = Color(0xFF1E1E2C);

  // AppBar text and icon color in dark mode
  static const Color _darkAppBarForegroundColor = Colors.white;

  // FloatingActionButton background color in dark mode
  static const Color _darkFABBackgroundColor = Colors.blueAccent;

  // FloatingActionButton icon color in dark mode
  static const Color _darkFABForegroundColor = Colors.black;

  // ElevatedButton background color in dark mode
  static const Color _darkButtonBackgroundColor = Colors.blueAccent;

  // ElevatedButton text color in dark mode
  static const Color _darkButtonForegroundColor = Colors.black;

  /// Light Theme: Uses a blue primary color with Material 3 principles.
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _lightPrimaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightAppBarBackgroundColor,
      foregroundColor: _lightAppBarForegroundColor,
      elevation: 4,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightFABBackgroundColor,
      foregroundColor: _lightFABForegroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightButtonBackgroundColor,
        foregroundColor: _lightButtonForegroundColor,
      ),
    ),
  );

  /// Dark Theme: Uses a softer blue tone for better contrast with dark backgrounds.
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _darkPrimaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkAppBarBackgroundColor,
      foregroundColor: _darkAppBarForegroundColor,
      elevation: 4,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkFABBackgroundColor,
      foregroundColor: _darkFABForegroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkButtonBackgroundColor,
        foregroundColor: _darkButtonForegroundColor,
      ),
    ),
  );
}
