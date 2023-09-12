import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar_overlay.dart';
import '../widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      // pull reference from the file
      await fireAuth.sendPasswordResetEmail(
          email: _emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Reset link sent! Please check your email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      //print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarOverlay(),
      bottomNavigationBar: const CustomNavBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Please enter your email and a password reset link will be emailed to you',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF6600)),
                ),
                hintText: 'Email',
                fillColor: Color.fromARGB(255, 207, 211, 212),
                filled: true,
              ),
            ),
          ),
          const SizedBox(height: 70),
          MaterialButton(
            onPressed: passwordReset,
            color: const Color(0xFFFF6600),
            child: const Text('Reset Password'),
          ),
        ],
      ),
    );
  }
}
