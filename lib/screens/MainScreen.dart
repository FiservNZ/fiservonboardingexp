import 'package:fiservonboardingexp/screens/training_page.dart';
import 'package:flutter/material.dart';
import 'NavAppOverlay.dart';
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
    TrainingPage(),
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
