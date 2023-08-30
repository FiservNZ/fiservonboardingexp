import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/screens/manager_page.dart';
import 'package:flutter/material.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';
import 'package:fiservonboardingexp/screens/main_screen.dart';

class CheckUser extends StatefulWidget {
  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  String position = '';

  @override
  void initState() {
    super.initState();
    checkUserAndNavigate();
  }

  Future<void> checkUserAndNavigate() async {
    await fetchUser();
    print(position);

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // User is not logged in, navigate to the LoginPage.
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        // User is logged in, navigate to the appropriate screen.
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => position == 'manager'
                    ? const ManagerPage()
                    : const MainScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> fetchUser() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final userCollection = FirebaseFirestore.instance.collection('User');

      DocumentSnapshot snapshot = await userCollection.doc(uid).get();

      if (snapshot.exists) {
        setState(() {
          position = snapshot['position'];
        });
      } else {
        // Handle the case where the user doesn't exist.
        print('Error, user not found!');
      }
    } catch (e) {
      // Handle the error appropriately.
      print('Error fetching user data: $e');
    }
  }
}
