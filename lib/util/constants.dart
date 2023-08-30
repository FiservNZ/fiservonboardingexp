import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/app_bar_overlay.dart';

const myAppBar = AppBarOverlay();

const myDrawer = Drawer(
  backgroundColor: Colors.grey,
  child: Column(children: [
    DrawerHeader(child: Icon(Icons.favorite)),
    ListTile(
      leading: Icon(Icons.home),
      title: Text('D A S H B O A R D'),
    ),
    ListTile(
      leading: Icon(Icons.chat_bubble),
      title: Text('M E S S A G E'),
    ),
    ListTile(
      leading: Icon(Icons.settings),
      title: Text('S E T T I N G S'),
    ),
    ListTile(
      leading: Icon(Icons.logout),
      title: Text('L O G O U T'),
    ),
  ]),
);

const navBar = CustomNavBar();

var fontStyle = GoogleFonts.quicksand();
const fontWeight = FontWeight.bold;
const headerFontSize = 24;
const bodyFontSize = 18;

const fiservColor = Color.fromARGB(255, 255, 102, 0);

// Light Mode Colors
var lightBackgroundColor = Colors.grey[50];
var lightBars = Colors.grey[200];
var lightTileColor = Colors.amber[800];
var lightTextColor = Colors.black;

// Dark Mode Colors
// Nav/App Bar uses black & fiserv color.
var darkBackgroundColor = Colors.blueGrey[50];
var darkBars = Colors.black;
var darkTileColor = Colors.black87;
var darkTextColor = Colors.white;
