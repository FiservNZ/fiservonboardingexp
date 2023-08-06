import 'package:fiservonboardingexp/screens/checklist.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/firebase_options.dart';

import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fiservonboardingexp/screens/teaser.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';
import 'screens/main_screen.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]); //Removes the device's status bar
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      home: LoginPage(),
    );
  }
}
