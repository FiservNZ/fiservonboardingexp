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

      surface: Color.fromARGB(255, 78, 79, 82), // Progress indicator background
      onSurface:
          Color.fromARGB(255, 30, 44, 39), //disabled button background color
      onPrimary: Color.fromARGB(255, 51, 75, 67), //disabled button text color
    ));
