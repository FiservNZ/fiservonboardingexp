import 'package:flutter/material.dart';

//light mode
final ThemeData rainforestTheme = ThemeData(
  brightness: Brightness.light,

  //appbar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 2, 80, 18),
    elevation: 0,
    iconTheme: IconThemeData(
      color: Color.fromARGB(255, 3, 0, 3),
    ),
    titleTextStyle: TextStyle(
      color: Color.fromARGB(255, 5, 41, 6),
    ),
  ),

  //Other colours
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 80, 129, 95),
    primary: Color.fromARGB(255, 70, 53, 8),
    secondary: Color.fromARGB(255, 145, 113, 18),
  ),
);
