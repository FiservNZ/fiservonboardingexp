import 'package:flutter/material.dart';
import 'achievements_page.dart';
import 'home_page.dart';
import 'modules_page.dart';
import 'colleagues_page.dart';
import 'urgent_tasks_page.dart';
import 'appBarOverlay.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _NavAppOverlay createState() => _NavAppOverlay();
}

class NavAppOverlay extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const NavAppOverlay({
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'Modules',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            label: 'Urgent Tasks',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Achievements',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search_outlined),
            label: 'Colleagues',
            backgroundColor: Colors.black,
          ),
        ],
        selectedItemColor: FiservColor,
        unselectedItemColor: FiservColor,
      ),
    );
  }
}

const FiservColor = Color(0xFFFF6600);
