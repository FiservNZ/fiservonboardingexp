import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),

            //Title
            Text(
              '\n App Tutorial',
              style: TextStyle(
                color: selectedTheme.colorScheme.secondary,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ).merge(
                GoogleFonts.quicksand(), // Merge styles with GoogleFonts
              ),
            ),

            const SizedBox(height: 80),

            //Content
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                '\n\n An instructional guide to help navigate the app',
                style: TextStyle(
                  color: selectedTheme.colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ).merge(
                  GoogleFonts.quicksand(), // Merge styles with GoogleFonts
                ),
                textAlign: TextAlign.center, // Align text to the left
              ),
            ),

            //const SizedBox(height: 0),

            //Close button
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    //change to pop function
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: selectedTheme.colorScheme.onBackground),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: selectedTheme.colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ).merge(GoogleFonts
                        .quicksand()), // Merge styles with GoogleFonts
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
