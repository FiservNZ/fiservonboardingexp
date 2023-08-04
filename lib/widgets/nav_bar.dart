import 'package:fiservonboardingexp/screens/achievements_page.dart';
import 'package:fiservonboardingexp/screens/colleagues_page.dart';
import 'package:fiservonboardingexp/screens/home_page.dart';
import 'package:fiservonboardingexp/screens/training_page.dart';
import 'package:fiservonboardingexp/screens/urgent_tasks_page.dart';
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
            Navigator.push(context, _instantPageRoute(const UrgentTasksPage()));
            break;
          case 3:
            Navigator.push(
                context, _instantPageRoute(const AchievementsPage()));
            break;
          case 4:
            Navigator.push(context, _instantPageRoute(const ColleaguesPage()));
            break;
        }
      },
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
          label: 'Tasks',
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
