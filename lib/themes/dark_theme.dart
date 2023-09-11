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
    primary: const Color.fromARGB(255, 75, 73, 73)!,
    secondary: const Color(0xFFFF6600),
  ),
);
