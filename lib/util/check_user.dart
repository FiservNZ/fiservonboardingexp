import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:fiservonboardingexp/screens/manager/manager_view.dart';
import 'package:fiservonboardingexp/themes/Theme_database.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';
import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:provider/provider.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  String position = '';

  @override
  void initState() {
    super.initState();
    // Call the function to check the user and navigate accordingly.
    checkUserAndNavigate();
    retrieveAndApplyTheme();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> checkUserAndNavigate() async {
    // Wait for user data to be fetched.
    await fetchUser();
    print(position);

    // Listen for changes in the user's authentication state.
    fireAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        // User is not logged in, navigate to the LoginPage.
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        // User is logged in, navigate to the appropriate screen based on their position.
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => position == 'manager'
                    ? ManagerView()
                    : const MainScreen()));
      }
    });
  }

  Future<void> fetchUser() async {
    try {
      String uid = fireAuth.currentUser!.uid;
      // Fetch user data from Firestore using the user's UID.
      DocumentSnapshot snapshot = await userColRef.doc(uid).get();

      if (snapshot.exists) {
        // Update the 'position' variable based on the user's data.
        setState(() {
          position = snapshot['position'];
        });
      } else {
        // Handle the case where the user doesn't exist.
        print('Error, user not found!');
      }
    } catch (e) {
      // Handle any errors that may occur during data fetching.
      print('Error fetching user data: $e');
    }
  }

  // Method to retrieve and apply the theme from Firebase
  Future<void> retrieveAndApplyTheme() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final stringThemeData =
          await ThemeDatabase().getThemePreference(currentUser.uid);
      if (stringThemeData != null) {
        final themeData = stringToThemeData(stringThemeData);
        // Apply the retrieved theme using the stored context
        themeProvider.setTheme(themeData);
      }
    }
  }
}
