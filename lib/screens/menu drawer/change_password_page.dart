import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../firebase references/firebase_refs.dart';
import '../../widgets/app_bar_overlay.dart';
import '../../widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _emailController = TextEditingController();
  final Logger _logger = Logger();

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
      _logger.e("Password reset failed: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      appBar: const AppBarOverlay(),
      bottomNavigationBar: const CustomNavBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Please enter your email and a password reset link will be emailed to you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedTheme.colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ).merge(
                    GoogleFonts.quicksand()), // Merge styles with GoogleFonts
              ),
            ),

            const SizedBox(height: 60),

            // Email textfield
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

            const SizedBox(height: 70),

            // Reset password button
            MaterialButton(
              onPressed: passwordReset,
              color: selectedTheme.colorScheme.onBackground,
              child: Text(
                'Reset Password',
                style: TextStyle(
                  color: selectedTheme.colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ).merge(
                    GoogleFonts.quicksand()), // Merge styles with GoogleFonts
              ),
            ),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    selectedTheme.colorScheme.onBackground,
                  ),
                ),
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: selectedTheme.colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ).merge(
                      GoogleFonts.quicksand()), // Merge styles with GoogleFonts
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
