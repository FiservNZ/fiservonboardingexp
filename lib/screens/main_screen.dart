import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/idk/training%20categories/compliance_page.dart';
import 'package:flutter/material.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'achievements_page.dart';
import 'colleagues_page.dart';
import 'home_page.dart';
import 'checklist_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    const SecurityTasks(),
    ChecklistPage(firestore: FirebaseFirestore.instance),
    AchievementsPage(),
    const ColleaguesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: const CustomNavBar(),
      extendBody: true,
    );
  }
}
