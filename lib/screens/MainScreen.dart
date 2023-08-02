import 'package:fiservonboardingexp/screens/task_categories/compliance_page.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'navAppOverlay.dart';
import 'achievements_page.dart';
import 'colleagues_page.dart';
import 'home_page.dart';
import 'appBarOverlay.dart';
import 'urgent_tasks_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarOverlay(),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: NavAppOverlay(),
      extendBody: true,
    );
  }
}
