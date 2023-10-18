import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    background: darkBackgroundColor, // Background.
    onBackground: darkTileColor, // Tiles.
    tertiary: darkBars, // App/nav bars.
    primary: darkTextColor, // Main text colour.
    secondary: fiservColor, // Headings.
    surface: const Color.fromARGB(
        255, 107, 107, 107), // Progress indicator background
    onSurface: const Color.fromARGB(
        255, 24, 24, 24), //disabled button background color
    onPrimary:
        const Color.fromARGB(255, 66, 66, 66), //disabled button text color
  ),
);
