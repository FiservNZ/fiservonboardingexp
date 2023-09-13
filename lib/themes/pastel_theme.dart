import 'package:flutter/material.dart';

//light mode
final ThemeData pastelTheme = ThemeData(
  brightness: Brightness.light,

  //Other colours
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 245, 213, 235), // Background
    onBackground: Color.fromARGB(255, 231, 230, 151), // Tiles
    tertiary: Color.fromARGB(255, 159, 224, 176), // App/nav bars
    primary: Color.fromARGB(255, 79, 187, 214), // Main text colour
    secondary: Color.fromARGB(255, 171, 133, 231), // Headings
  ),
);
