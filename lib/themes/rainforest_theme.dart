import 'package:flutter/material.dart';

//light mode.
final ThemeData rainforestTheme = ThemeData(
  brightness: Brightness.light,

  //Other colours.
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 80, 129, 95), // Background
    onBackground: Color.fromARGB(255, 99, 156, 98), // Tiles
    tertiary: Color.fromARGB(255, 20, 145, 72), // App/nav bars
    primary: Color.fromARGB(255, 9, 70, 34), // Main text colour
    secondary: Color(0xFF241a16), // Headings
    onTertiary: Colors.white,
  ),
);
