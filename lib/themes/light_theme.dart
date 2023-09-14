import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

//light mode
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  //Other colours
  colorScheme: ColorScheme.light(
    background: lightBackgroundColor, // Background
    onBackground: lightTileColor, // Tiles
    tertiary: lightBars, // App/nav bars
    primary: lightTextColor, // Main text colour
    secondary: fiservColor, // Headings
  ),
);
