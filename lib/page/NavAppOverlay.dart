import 'package:fiserv/page/colleagues_page.dart';
import 'package:fiserv/page/profile_page.dart';
import 'package:fiserv/page/urgent_tasks_page.dart';
import 'package:flutter/material.dart';
import 'achievements_page.dart';
import 'home_page.dart';
import 'modules_page.dart';
import 'page/home_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _NavAppOverlay createState() => _NavAppOverlay();
}

class _NavAppOverlay extends State<MyHomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const ModulesPage(),
    const UrgentTasksPage(),
    const AchievementsPage(),
    const ColleaguesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rank Name'),
        elevation: 0,
        backgroundColor: FiservColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/userIcon.png'),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.help_outline, size: 30),
          ),
        ],
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