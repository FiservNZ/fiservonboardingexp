import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/screens/menu%20drawer/change_password_page.dart';
import 'package:fiservonboardingexp/themes/Theme_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../themes/theme_provider.dart';
import '../../widgets/app_bar_overlay.dart';
import 'package:fiservonboardingexp/screens/themes_page.dart';
import 'package:fiservonboardingexp/themes/dark_theme.dart';
import 'package:fiservonboardingexp/themes/light_theme.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final ThemeDatabase _firebaseTheme = ThemeDatabase();

  // Updates to the new theme
  void _handleThemeChange(ThemeData theme, ThemeProvider themeProvider) {
    themeProvider.setTheme(theme);

    // Save the selected theme mode to Firebase Firestore
    _firebaseTheme.saveThemePreference(currentUser.uid, theme);
  }

  double edgePadding = 60;
  double iconTxtSpacing = 30;
  double listSpacing = 30;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    return Scaffold(
      key: _scaffoldKey, // Set the GlobalKey<ScaffoldState>
      backgroundColor: selectedTheme.colorScheme.background,
      appBar: const AppBarOverlay(),
      bottomNavigationBar: const CustomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Heading
            Text(
              '\n Settings',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: selectedTheme.colorScheme.secondary,
              ).merge(GoogleFonts.quicksand()),
            ),

            // Spacing
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: edgePadding),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.lightbulb,
                          color: selectedTheme.colorScheme.primary),
                      SizedBox(
                          width:
                              iconTxtSpacing), // Add spacing between icon and text
                      Text(
                        'Dark/Light Mode',
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts.quicksand()),
                      ),
                      Switch(
                        value: selectedTheme == lightTheme,
                        onChanged: (value) {
                          if (value) {
                            _handleThemeChange(lightTheme, themeProvider);
                          } else {
                            _handleThemeChange(darkTheme, themeProvider);
                          }
                        },
                        activeColor: selectedTheme.colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 21),

            //Themes
            Container(
              margin: EdgeInsets.symmetric(horizontal: edgePadding),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ThemesPage();
                  }));
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.color_lens,
                        color: selectedTheme.colorScheme.primary),
                    SizedBox(
                        width:
                            iconTxtSpacing), // Add some spacing between icon and text
                    Text(
                      'Themes',
                      style: TextStyle(
                        color: selectedTheme.colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ).merge(GoogleFonts.quicksand()),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: listSpacing),

            //Change password
            Container(
              margin: EdgeInsets.symmetric(horizontal: edgePadding),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ChangePasswordPage();
                  }));
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.change_circle_outlined,
                        color: selectedTheme.colorScheme.primary),
                    SizedBox(
                        width:
                            iconTxtSpacing), // Add some spacing between icon and text
                    Text(
                      'Change Password',
                      style: TextStyle(
                        color: selectedTheme.colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ).merge(GoogleFonts.quicksand()),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: listSpacing),

            //Close button
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTheme.colorScheme.onBackground,
                  ),
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
