import 'package:fiservonboardingexp/screens/achievements_page.dart';
import 'package:fiservonboardingexp/screens/colleagues_page.dart';
import 'package:fiservonboardingexp/screens/home_page.dart';
import 'package:fiservonboardingexp/screens/training_page.dart';
import 'package:fiservonboardingexp/screens/checklist_page.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/mc_testing/module/module_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase references/firebase_refs.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

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
            Navigator.push(context, _instantPageRoute(const ModuleScreen()));
            break;
          // Directs user to the General Checklist Page
          case 2:
            Navigator.push(
                context,
                _instantPageRoute(
                  ChecklistPage(firestore: firestore),
                ));
            break;
          // Directs user to the Achievements Page
          case 3:
            Navigator.push(context, _instantPageRoute(AchievementsPage()));
            break;
          // Directs user to the Colleagues Page
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
