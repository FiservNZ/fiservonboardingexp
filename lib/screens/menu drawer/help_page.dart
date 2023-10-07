import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/widgets/help_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);

    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                'App Tutorial',
                style: GoogleFonts.quicksand(
                  color: selectedTheme.colorScheme.secondary,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // Content
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'An instructional guide to help navigate the app',
                  style: GoogleFonts.quicksand(
                    color: selectedTheme.colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              const Expanded(child: HelpList()),

              const SizedBox(height: 30),

              // Close button
              ElevatedButton(
                onPressed: () {
                  // Change to pop function to go back to the previous screen
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedTheme.colorScheme.onBackground,
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.quicksand(
                    color: selectedTheme.colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
