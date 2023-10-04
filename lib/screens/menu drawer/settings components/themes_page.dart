import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/themes/theme_database.dart';
import 'package:fiservonboardingexp/themes/beach_theme.dart';
import 'package:fiservonboardingexp/themes/pastel_theme.dart';
import 'package:fiservonboardingexp/themes/rainforest_theme.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ThemesPage extends StatefulWidget {
  const ThemesPage({Key? key}) : super(key: key);

  @override
  ThemesPageState createState() => ThemesPageState();
}

class ThemesPageState extends State<ThemesPage> {
  // Create an instance of ThemeDatabase for managing theme-related data.
  final ThemeDatabase _firebaseTheme = ThemeDatabase();

  // Function to handle theme change and update the theme provider.
  void _handleThemeChange(ThemeData theme, ThemeProvider themeProvider) {
    themeProvider.setTheme(theme);

    // Save the selected theme mode to Firebase Firestore
    _firebaseTheme.saveThemePreference(uid, theme);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),

            // Heading
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'Select a Theme:',
                style: GoogleFonts.quicksand(
                  color: selectedTheme.colorScheme.secondary,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Rainforest theme
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 50), // Adjust the vertical margin
              child: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: selectedTheme.colorScheme.primary,
                ),
                child: RadioListTile<ThemeData>(
                  title: Text(
                    'Rainforest Theme',
                    style: GoogleFonts.quicksand(
                      color: selectedTheme.colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: rainforestTheme,
                  groupValue: selectedTheme,
                  onChanged: (value) {
                    _handleThemeChange(rainforestTheme, themeProvider);
                  },
                  activeColor: selectedTheme.colorScheme.primary,
                ),
              ),
            ),

            // Pastel theme
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 50), // Adjust the vertical margin
              child: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: selectedTheme.colorScheme.primary,
                ),
                child: RadioListTile<ThemeData>(
                  title: Text(
                    'Pastel Theme',
                    style: GoogleFonts.quicksand(
                      color: selectedTheme.colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Radio widget for selecting the "Pastel" theme.
                  value: pastelTheme,
                  groupValue: selectedTheme,
                  onChanged: (value) {
                    _handleThemeChange(pastelTheme, themeProvider);
                  },
                  // The color to use when the radio button is selected.
                  activeColor: selectedTheme.colorScheme.primary,
                ),
              ),
            ),

            // Beach theme
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 50), // Adjust the vertical margin
              child: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: selectedTheme.colorScheme.primary,
                ),
                child: RadioListTile<ThemeData>(
                  title: Text(
                    'Beach Theme',
                    style: GoogleFonts.quicksand(
                      color: selectedTheme.colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: beachTheme,
                  groupValue: selectedTheme,
                  onChanged: (value) {
                    _handleThemeChange(beachTheme, themeProvider);
                  },
                  activeColor: selectedTheme.colorScheme.primary,
                ),
              ),
            ),

            const SizedBox(height: 80),

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
                  style: GoogleFonts.quicksand(
                    color: selectedTheme.colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
