import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/screens/training_page.dart';
import 'package:flutter/material.dart';
import 'Nav_App_Overlay.dart';
import 'achievements_page.dart';
import 'colleagues_page.dart';
import 'home_page.dart';
import '../widgets/app_bar_overlay.dart';
import 'checklist_page.dart';
import '../main.dart'; // Import main.dart

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const TrainingPage(),
    ChecklistPage(firestore: FirebaseFirestore.instance),
    AchievementsPage(),
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
      bottomNavigationBar: NavAppOverlay(
        currentIndex: currentIndex,
        onTabTapped: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      extendBody: true,
    );
  }
}
