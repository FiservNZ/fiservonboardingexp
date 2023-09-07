import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:fiservonboardingexp/screens/achievements_page.dart';
import 'package:fiservonboardingexp/screens/colleagues_page.dart';
import 'package:fiservonboardingexp/screens/home_page.dart';
import 'package:fiservonboardingexp/screens/training_page.dart';
import 'package:fiservonboardingexp/screens/checklist_page.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: (int newIndex) {
        switch (newIndex) {
          case 0:
            Navigator.of(context).push(_instantPageRoute(const HomePage()));
            break;
          case 1:
            Navigator.push(context, _instantPageRoute(const TrainingPage()));
            break;
          case 2:
            Navigator.push(
                context,
                _instantPageRoute(
                  ChecklistPage(firestore: firestore),
                ));
            break;
          case 3:
            Navigator.push(context, _instantPageRoute(AchievementsPage()));
            break;
          case 4:
            Navigator.push(context, _instantPageRoute(const ColleaguesPage()));
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: darkBars,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.my_library_books),
          label: 'Modules',
          backgroundColor: darkBars,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.format_list_bulleted_sharp),
          label: 'Checklist',
          backgroundColor: darkBars,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.task_alt),
          label: 'Achievements',
          backgroundColor: darkBars,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_search_outlined),
          label: 'Colleagues',
          backgroundColor: darkBars,
        ),
      ],
      selectedItemColor: fiservColor,
      unselectedItemColor: fiservColor,
      backgroundColor: Color(0xFF111211),
      selectedFontSize: 12.0,
      unselectedFontSize: 12.0,
    );
  }

  PageRouteBuilder _instantPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}
