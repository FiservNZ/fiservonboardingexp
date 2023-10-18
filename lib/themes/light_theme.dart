import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

//light mode.
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: lightBackgroundColor, // Background.
    onBackground: lightTileColor, // Tiles.
    tertiary: lightBars, // App/nav bars.
    primary: lightTextColor, // Main text colour.
    secondary: fiservColor, // Headings.
    onTertiary: Colors.black,
    surface: const Color.fromARGB(
        255, 230, 226, 226), // Progress indicator background
    onSurface: const Color.fromARGB(
        255, 223, 223, 223), //disabled button background color
    onPrimary:
        const Color.fromARGB(255, 189, 188, 188), //disabled button text color
  ),
);
