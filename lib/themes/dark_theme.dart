import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  //appbar
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Color(0xFFFF6600),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFFFF6600),
    ),
  ),

  //Other colours
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(255, 0, 0, 0),
    onBackground: const Color.fromARGB(255, 53, 49, 49), //App bar
    primary:
        Color.fromARGB(255, 255, 255, 255)!, // Mainly used for the text colour
    secondary: const Color(0xFFFF6600), // Mainly used for headings
    tertiary: Color.fromARGB(255, 129, 127, 125), // Mainly used for buttons
  ),
);
