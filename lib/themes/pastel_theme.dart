import 'package:flutter/material.dart';

//light mode
final ThemeData pastelTheme = ThemeData(
  brightness: Brightness.light,

  //Other colours
  colorScheme: const ColorScheme.light(
    background: Color(0xFFfdf6f6), // Background
    onBackground: Color(0xFFffeeb9a2), // Tiles
    tertiary: Color(0xFFc0d8e3), // App/nav bars
    primary: Color(0xFFe18a7a), // Main text colour
    secondary: Color(0xFFa78d8a), // Headings
  ),
);
