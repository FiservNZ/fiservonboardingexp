import 'package:flutter/material.dart';

//light mode.
final ThemeData beachTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFfffced), // Background.
    onBackground: Color.fromARGB(255, 240, 229, 188), // Tiles.
    tertiary: Color(0xFF152a69), // App/nav bars.
    primary: Color(0xFF446da3), // Main text colour.
    secondary: Color.fromARGB(255, 9, 153, 185), // Headings.
    surface:
        Color.fromARGB(255, 167, 166, 166), // Progress indicator background
    onSurface:
        Color.fromARGB(255, 245, 242, 227), //disabled button background color
    onPrimary: Color.fromARGB(255, 207, 204, 192), //disabled button text color
  ),
);
