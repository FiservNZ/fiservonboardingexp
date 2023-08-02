import 'package:flutter/material.dart';

class NavAppOverlay extends StatefulWidget {
  @override
  _NavAppOverlayState createState() => _NavAppOverlayState();
}

class _NavAppOverlayState extends State<NavAppOverlay> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
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

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

const FiservColor = Color(0xFFFF6600);
