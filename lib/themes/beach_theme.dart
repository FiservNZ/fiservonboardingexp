import 'package:flutter/material.dart';

//light mode.
final ThemeData beachTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFfffced), // Background.
    onBackground: Color(0xFF92becb), // Tiles.
    tertiary: Color(0xFF152a69), // App/nav bars.
    primary: Color(0xFF446da3), // Main text colour.
    secondary: Color(0xFF189ebb), // Headings.
    onTertiary: Colors.white,
    surface:
        Color.fromARGB(255, 167, 166, 166), // Progress indicator background
  ),
);
