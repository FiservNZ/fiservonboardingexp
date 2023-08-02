import 'package:fiservonboardingexp/config/app_router.dart';
import 'package:fiservonboardingexp/screens/Login_page.dart';
import 'package:fiservonboardingexp/screens/home_page.dart';
import 'package:fiservonboardingexp/screens/task_categories/compliance_page.dart';
import 'package:fiservonboardingexp/screens/task_categories/week_one_page.dart';
import 'package:fiservonboardingexp/screens/training_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fiservonboardingexp/screens/teaser.dart';
import 'package:fiservonboardingexp/screens/navAppOverlay.dart';
import 'screens/MainScreen.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Skeleton',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initScreen == 0 || initScreen == null ? 'teaser' : 'home',
      routes: {
        'home': (context) => MainScreen(),
        'teaser': (context) => const TeaserScreen(),
      },
    );
  }
}
