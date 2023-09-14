import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../util/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // Create a TextEditingController to manage the email input field.
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the _emailController when the widget is disposed.
    _emailController.dispose();
    super.dispose();
  }

  // Function to reset the password.
  Future passwordReset() async {
    try {
      // Send a password reset email using Firebase Authentication.
      await fireAuth.sendPasswordResetEmail(
          email: _emailController.text.trim());

      // Show a success dialog when the reset link is sent.
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Reset link sent! Please check your email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException and show an error dialog.
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
    // Access the current theme from the theme provider.
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text: Instructions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Please enter your email and a password reset link will be emailed to you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedTheme.colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ).merge(GoogleFonts.quicksand()),
              ),
            ),

            const SizedBox(height: 60),

            // Email input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 150, 78, 78)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: selectedTheme.colorScheme.secondary),
                  ),
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
