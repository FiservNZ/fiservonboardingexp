import 'package:flutter/material.dart';
import '../util/constants.dart';
import '../widgets/nav_bar.dart';
import 'checklist.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: CustomNavBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, left: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Achievements Page',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
