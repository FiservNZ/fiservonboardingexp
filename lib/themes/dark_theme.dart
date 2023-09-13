import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  //Other colours
  colorScheme: const ColorScheme.dark(
    //Design #2
    //background: Color.fromARGB(255, 27, 27, 27), // Background
    //onBackground: Colors.black87, // Tiles
    //tertiary: Colors.black, //App bar

    background: Color(0xFF000000), // Background
    onBackground: Color(0xFF1b1b1d), // Tiles
    tertiary: Color(0xFF111211), // App/nav bars
    primary: Color.fromARGB(255, 255, 255, 255), // Main text colour
    secondary: Color(0xFFFF6600), // Headings
  ),
);
