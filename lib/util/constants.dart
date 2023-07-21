import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

final myAppBar = AppBar(
  backgroundColor: const Color.fromARGB(255, 15, 15, 15),
);

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

final navBar = Container(
  color: Colors.black,
  child: const Padding(
    padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 15),
    child: GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: fiservColor,
        padding: EdgeInsets.all(10),
        gap: 8,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(icon: Icons.favorite_border, text: 'Favs'),
          GButton(icon: Icons.search, text: 'Search'),
          GButton(icon: Icons.library_books, text: 'Modules'),
        ]),
  ),
);

const myBackgroundColor = Color.fromARGB(255, 39, 39, 39);
const fiservColor = Color.fromARGB(255, 255, 102, 0);
