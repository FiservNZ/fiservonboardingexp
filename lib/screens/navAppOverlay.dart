import 'package:fiservonboardingexp/training_page.dart';
import 'package:fiservonboardingexp/week_one_page.dart';
import 'package:flutter/material.dart';
import '../security_tasks_page.dart';
import 'achievements_page.dart';
import 'home_page.dart';
import 'modules_page.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'colleagues_page.dart';
import 'profile_page.dart';
import 'urgent_tasks_page.dart';
import 'appBarOverlay.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _NavAppOverlay createState() => _NavAppOverlay();
}

class _NavAppOverlay extends State<MyHomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    SecurityTasks(),
    const UrgentTasksPage(),
    const AchievementsPage(),
    const ColleaguesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: const AppBarOverlay(),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: FiservColor,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            backgroundColor: FiservColor,
            label: 'Modules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            backgroundColor: FiservColor,
            label: 'Urgent Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            backgroundColor: FiservColor,
            label: 'Achievements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search_outlined),
            backgroundColor: FiservColor,
            label: 'Colleagues',
          ),
        ],
      ),
    );
  }
}

const FiservColor = Color(0xFFFF6600);
