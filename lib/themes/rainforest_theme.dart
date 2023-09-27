import 'package:flutter/material.dart';

//light mode.
final ThemeData rainforestTheme = ThemeData(
  brightness: Brightness.light,

  //Other colours.
  colorScheme: const ColorScheme.light(
    background: Color(0xFF243630), // Background
    onBackground: Color(0xFF2d3a3c), // Tiles
    tertiary: Color(0xFF4c4839), // App/nav bars
    primary: Color.fromARGB(255, 124, 106, 80), // Main text colour
    secondary: Color.fromARGB(255, 156, 159, 165), // Headings
    onTertiary: Colors.pink,
    surface: Color.fromARGB(255, 78, 79, 82), // Progress indicator background
  ),
);
