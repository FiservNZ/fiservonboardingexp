import 'package:fiservonboardingexp/config/app_router.dart';
import 'package:fiservonboardingexp/screens/home_screen.dart';
import 'package:fiservonboardingexp/screens/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/firebase_options.dart';

// Import class from another file
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const LoginApp());
}
