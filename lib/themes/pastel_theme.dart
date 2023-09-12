import 'package:flutter/material.dart';

//light mode
final ThemeData pastelTheme = ThemeData(
  brightness: Brightness.light,

  //appbar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 216, 158, 197),
    elevation: 0,
    iconTheme: IconThemeData(
      color: Color.fromARGB(255, 230, 134, 209),
    ),
    titleTextStyle: TextStyle(
      color: Color.fromARGB(255, 77, 213, 255),
    ),
  ),

  //Other colours
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 245, 203, 232),
    onBackground: Color.fromARGB(255, 228, 226, 101), //App bar
    primary:
        Color.fromARGB(255, 76, 173, 197), // Mainly used for the text colour
    secondary: Color.fromARGB(255, 171, 133, 231), // Mainly used for headings
    tertiary: Color.fromARGB(255, 81, 216, 182), // Mainly used for buttons
  ),
);
