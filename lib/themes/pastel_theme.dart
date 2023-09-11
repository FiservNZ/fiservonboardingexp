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
    primary: Color.fromARGB(255, 76, 173, 197),
    secondary: Color.fromARGB(255, 194, 154, 226),
  ),
);
