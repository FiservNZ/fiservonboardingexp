import 'package:flutter/material.dart';

//light mode.
final ThemeData pastelTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFfdf6f6), // Background.
    onBackground: Color.fromARGB(255, 221, 201, 215), // Tiles.
    tertiary: Color(0xFFc0d8e3), // App/nav bars.
    primary: Color(0XFFC47482), // Main text colour.
    secondary: Color(0xFFa78d8a), // Headings.
    surface:
        Color.fromARGB(255, 221, 218, 218), // Progress indicator background
    onSurface:
        Color.fromARGB(255, 241, 234, 234), //disabled button background color
    onPrimary: Color.fromARGB(255, 211, 204, 204), //disabled button text color
  ),
);
