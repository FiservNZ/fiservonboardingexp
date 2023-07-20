import 'package:fiservonboardingexp/config/app_router.dart';
import 'package:fiservonboardingexp/screens/home_screen.dart';
import 'package:fiservonboardingexp/screens/profile_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fiserv Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: ProfilePage.routeName,
    );
  }
}
