import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  //brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    //Design #2
    //background: Color.fromARGB(255, 27, 27, 27), // Background.
    //onBackground: Colors.black87, // Tiles.
    //tertiary: Colors.black, //App bar.

    background: darkBackgroundColor, // Background.
    onBackground: darkTileColor, // Tiles.
    tertiary: darkBars, // App/nav bars.
    primary: darkTextColor, // Main text colour.
    secondary: fiservColor,
    onTertiary: Colors.white, // Headings.
  ),
);
