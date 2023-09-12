import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/app_bar_overlay.dart';

const myAppBar = AppBarOverlay();
const navBar = CustomNavBar();

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
var lightBackgroundColor = Colors.grey[50];
var lightBars = Colors.grey[200];
var lightTileColor = Colors.amber[800];
var lightTextColor = Colors.black;

// Dark Mode Colors
// Nav/App Bar uses black & fiserv color.
var darkBackgroundColor = const Color.fromARGB(255, 27, 27, 27);
var darkBars = Colors.black;
var darkTileColor = Colors.black87;
var darkTextColor = Colors.white;
var darkHeaderFontStyle = GoogleFonts.quicksand(
    fontWeight: fontWeight, fontSize: headerFontSize, color: darkTextColor);
var darkBodyFontStyle = GoogleFonts.quicksand(
    fontWeight: fontWeight, fontSize: bodyFontSize, color: darkTextColor);
