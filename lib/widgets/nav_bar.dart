import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/screens/achievements_page.dart';
import 'package:fiservonboardingexp/screens/colleagues_page.dart';
import 'package:fiservonboardingexp/screens/home_page.dart';
import 'package:fiservonboardingexp/screens/training_page.dart';
import 'package:fiservonboardingexp/screens/checklist_page.dart';
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
          // Directs user to Home Page
          case 0:
            Navigator.of(context).push(_instantPageRoute(HomePage()));
            break;
          // Directs user to Training Page
          case 1:
            Navigator.push(context, _instantPageRoute(const TrainingPage()));
            break;
          // Directs user to the General Checklist Page
          case 2:
            Navigator.push(
                context,
                _instantPageRoute(
                  ChecklistPage(firestore: FirebaseFirestore.instance),
                ));
            break;
          // Directs user to the Achievements Page
          case 3:
            Navigator.push(
                context, _instantPageRoute(const AchievementsPage()));
            break;
          // Directs user to the Colleagues Page
          case 4:
            Navigator.push(context, _instantPageRoute(const ColleaguesPage()));
            break;
        }
      },

      // Implementation for the icons, icon colours and icon label names
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
          icon: Icon(Icons.format_list_bulleted_sharp),
          label: 'Checklist',
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
      backgroundColor: Colors.black,
      selectedFontSize: 12.0,
      unselectedFontSize: 12.0,
    );
  }

  // Implementation for page transitions (purposely made it so that it has no animation and transition effect)
  PageRouteBuilder _instantPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}

const FiservColor = Color(0xFFFF6600);
