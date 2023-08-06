import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import '../screens/app_bar.dart';

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

final navBar = CustomNavBar();

const myBackgroundColor = Color.fromARGB(255, 39, 39, 39);
const fiservColor = Color.fromARGB(255, 255, 102, 0);
