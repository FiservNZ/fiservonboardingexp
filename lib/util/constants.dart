import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/app_bar_overlay.dart';

const myAppBar = AppBarOverlay();
const navBar = CustomNavBar();

ThemeData getSelectedTheme(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return themeProvider.currentTheme;
}

// Define the background color
Color getBackgroundColor(BuildContext context) {
  final selectedTheme = getSelectedTheme(context);
  return selectedTheme.colorScheme.background;
}

// Text font design style
const fontWeight = FontWeight.bold;
const headerFontSize = 24.0;
const bodyFontSize = 18.0;
var fontStyle = GoogleFonts.quicksand();
var headerFontStyle = GoogleFonts.quicksand(
    fontWeight: fontWeight, fontSize: headerFontSize, color: fiservColor);
var bodyFontStyle =
    GoogleFonts.quicksand(fontWeight: fontWeight, fontSize: bodyFontSize);

// Universal Colors
const fiservColor = Color.fromARGB(255, 255, 102, 0);

// Light Mode Colors
var lightBackgroundColor = const Color(0xFFe9e9e9);
var lightBars = Color.fromARGB(255, 217, 217, 219);
var lightTileColor = const Color(0xFFfefefe);
var lightTextColor = Colors.black;

// Dark Mode Colors
// Nav/App Bar uses black & fiserv color.
var darkBackgroundColor = const Color(0xFF000000);
var darkBars = const Color(0xFF111211);
var darkTileColor = const Color(0xFF1b1b1d);
var darkTextColor = Colors.white;
var darkHeaderFontStyle = GoogleFonts.quicksand(
    fontWeight: fontWeight, fontSize: headerFontSize, color: darkTextColor);
var darkBodyFontStyle = GoogleFonts.quicksand(
    fontWeight: fontWeight, fontSize: bodyFontSize, color: darkTextColor);
