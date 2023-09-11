import 'package:flutter/material.dart';

//light mode
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  //appbar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 189, 33, 33),
    elevation: 0,
    iconTheme: IconThemeData(
      color: Color(0xFFFF6600),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFFFF6600),
    ),
  ),

  //Other colours
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    primary: Color.fromARGB(255, 165, 161, 161),
    secondary: Color(0xFFFF6600),
  ),
);
