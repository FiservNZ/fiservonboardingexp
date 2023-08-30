import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:fiservonboardingexp/screens/manager_page.dart';
import 'package:fiservonboardingexp/screens/teaser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'help_page.dart';

// class Global {
//   static UserCredential? userCredential;
// }

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  Future handleLogin(BuildContext context) async {
    // get the information
    String username = usernameController.text;
    String password = passwordController.text;

    try {
      //detect the user account.
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      // //save userCredential in global varible
      // Global.userCredential = userCredential;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successfully.'),
          duration: Duration(seconds: 1),
        ),
      );

      checkUserPosition(context);

      print('Username: $username, Password: $password');
      // If the authentication is successful, the user is logged in.
    } catch (e) {
      // If there's an error, show an error message.
      if (username.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter both username and password.'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password.'),
            duration: Duration(seconds: 1),
          ),
        );
        print('Error during login');
      }
    }
    //
  }

  // Check user position
  void checkUserPosition(context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;

      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection('User').doc(uid).get();
        if (snapshot.exists) {
          String position = snapshot.data()!['position'];

          // Determin logic based on position
          if (position == 'developer') {
            bool isFirstLogin = snapshot.data()!['firstlog'];
            debugPrint('User is a developer.');
            // Update the 'firstlog' field if it's the first login
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MainScreen()));
            if (isFirstLogin) {
              debugPrint("go to the teaser page");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TeaserScreen())).then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelpPage(),
                  ),
                ),
              );
              await FirebaseFirestore.instance
                  .collection('User')
                  .doc(uid)
                  .update({'firstlog': false});
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const MainScreen())));
            }
          } else if (position == 'manager') {
            debugPrint('User is a manager.');
            //handle the manager mode below.
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const ManagerPage())));
          } else {
            debugPrint('User position unknown.');
          }
        } else {
          debugPrint('User data not found in Firestore.');
        }
      } catch (e) {
        debugPrint('Error retrieving user data: $e');
      }
    } else {
      debugPrint('User not logged in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fiservColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Fiserv_logo.png',
                    width: 400,
                    height: 100,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome to Firserv',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              // Wrap the Column with Expanded
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate the user to the Home page
                      handleLogin(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const fiservColor = Color(0xFFFF6600);
}
