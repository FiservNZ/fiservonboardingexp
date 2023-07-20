import 'package:fiservonboardingexp/screens/home_screen.dart';
import 'package:fiservonboardingexp/screens/profile_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    debugPrint('You are on the ${settings.name} screen.');

    switch (settings.name) {
      case '/':
        return HomePage.route();
      case ProfilePage.routeName:
        return ProfilePage.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
