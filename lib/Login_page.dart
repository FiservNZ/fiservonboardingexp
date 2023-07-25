import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// void main() {
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future _handleLogin(BuildContext context) async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successfully.')),
      );

      print('Username: $username, Password: $password');
      // If the authentication is successful, the user is logged in.
    } catch (e) {
      // If there's an error, show an error message.
      if (username.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please enter both username and password.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password.'),
          ),
        );
        print('Error during login:');
      }
    }
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  labelText: 'Username', border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: 'Password', border: OutlineInputBorder()),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate the user to the Home page
                _handleLogin(context);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
