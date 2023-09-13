import 'package:flutter/material.dart';

//light mode
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  //Other colours
  colorScheme: const ColorScheme.light(
    background: Color(0xFFe9e9e9), // Background
    onBackground: Color(0xFFfefefe), // Tiles
    tertiary: Color(0xFFfafafc), // App/nav bars
    primary: Colors.black, // Main text colour
    secondary: Color(0xFFFF6600), // Headings
  ),
);
