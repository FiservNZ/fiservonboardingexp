import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/screens/Login_page.dart';
import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatelessWidget {
  CheckUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainScreen();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
