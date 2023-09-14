import 'package:flutter/material.dart';

//light mode
final ThemeData rainforestTheme = ThemeData(
  brightness: Brightness.light,

  //Other colours
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 80, 129, 95), // Background
    onBackground: Color.fromARGB(255, 99, 156, 98), // Tiles
    tertiary: Color(0xFF241a16), // App/nav bars
    primary: Color.fromARGB(255, 43, 32, 4), // Main text colour
    secondary: Color.fromARGB(255, 9, 70, 34), // Headings
  ),
);
