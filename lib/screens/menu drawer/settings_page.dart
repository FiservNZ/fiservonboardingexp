import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/screens/menu%20drawer/change_password_page.dart';
import 'package:fiservonboardingexp/themes/Theme_database.dart';
import 'package:fiservonboardingexp/themes/beach_theme.dart';
import 'package:fiservonboardingexp/themes/pastel_theme.dart';
import 'package:fiservonboardingexp/themes/rainforest_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../themes/theme_provider.dart';
import '../../widgets/app_bar_overlay.dart';
import 'package:fiservonboardingexp/screens/menu%20drawer/themes_page.dart';
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

  bool isEnabledOS = false;

  // Updates to the new theme
  void _handleThemeChange(ThemeData theme, ThemeProvider themeProvider) {
    themeProvider.setTheme(theme);

    // Save the selected theme mode to Firebase Firestore
    _firebaseTheme.saveThemePreference(currentUser.uid, theme);
  }

  double edgePadding = 30;
  double iconTxtSpacing = 15;
  double listSpacing = 30;
  bool isdisabled = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    String currentThemeName = 'None';

    if (selectedTheme == rainforestTheme) {
      currentThemeName = 'Rainforest';
    } else if (selectedTheme == pastelTheme) {
      currentThemeName = 'Pastel';
    } else if (selectedTheme == beachTheme) {
      currentThemeName = 'Beach';
    }

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
              style: GoogleFonts.quicksand(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: selectedTheme.colorScheme.secondary,
              ),
            ),

            const SizedBox(height: 70),

            // OS controlled dark/light mode
            Row(
              children: [
                SizedBox(width: edgePadding),
                Icon(Icons.lightbulb, color: selectedTheme.colorScheme.primary),
                SizedBox(
                    width: iconTxtSpacing), // Add spacing between icon and text
                Text(
                  'OS enabled light/\ndark mode',
                  style: GoogleFonts.quicksand(
                    color: selectedTheme.colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 60),
                    Switch(
                      value: isEnabledOS,
                      onChanged: (value) {
                        setState(() {
                          isEnabledOS =
                              value; // Update isEnabled when the Switch is toggled
                        });

                        if (isEnabledOS) {
                          // Switch is turned on
                        } else {
                          // Switch is turned off
                        }
                      },
                      activeColor: selectedTheme.colorScheme.primary,
                    ),
                    Text(
                      isEnabledOS ? 'on' : 'off',
                      style: GoogleFonts.quicksand(
                        color: isEnabledOS
                            ? selectedTheme.colorScheme.primary
                            : Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // OS controlled light/dark mode explanation
            Padding(
              padding: const EdgeInsets.only(
                  left: 70), // Set your desired padding here
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "(Enabling this feature allows it to be controlled\n by  your phone's  dark/light mode settings..)",
                  style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: selectedTheme.colorScheme.primary,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),

            SizedBox(height: listSpacing),

            // Light and Dark mode
            Row(
              children: [
                SizedBox(width: edgePadding),
                Icon(
                  Icons.lightbulb,
                  color: (isEnabledOS ||
                          selectedTheme == rainforestTheme ||
                          selectedTheme == pastelTheme ||
                          selectedTheme == beachTheme)
                      ? Colors.grey // Grey out the icon
                      : selectedTheme.colorScheme.primary,
                ),
                SizedBox(
                  width: iconTxtSpacing,
                ),
                Text(
                  'Light/dark mode', // Display "Light/Dark Mode On"
                  style: GoogleFonts.quicksand(
                    color: (isEnabledOS ||
                            selectedTheme == rainforestTheme ||
                            selectedTheme == pastelTheme ||
                            selectedTheme == beachTheme)
                        ? Colors.grey // Grey out the text
                        : selectedTheme.colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 63),
                Switch(
                  value: selectedTheme == lightTheme,
                  onChanged: (isEnabledOS)
                      ? null
                      : (value) {
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

            //  light/dark mode explanation
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Align(
                child: Text(
                  "(Turn off OS enabled light/dark mode to\n manually set the mode. This mode is\n deactivated when a theme is applied)",
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    color: (isEnabledOS ||
                            selectedTheme == rainforestTheme ||
                            selectedTheme == pastelTheme ||
                            selectedTheme == beachTheme)
                        ? Colors.grey // Grey out the text
                        : selectedTheme.colorScheme.primary,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: listSpacing),

            //Themes
            Container(
              margin: EdgeInsets.symmetric(horizontal: edgePadding),
              child: GestureDetector(
                onTap: () {
                  if (!isEnabledOS) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ThemesPage();
                    }));
                  }
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.color_lens,
                        color: isEnabledOS
                            ? Colors.grey // Grey out the icon
                            : selectedTheme.colorScheme.primary),
                    SizedBox(
                      width: iconTxtSpacing,
                    ), // Add some spacing between icon and text
                    Text(
                      'Themes',
                      style: GoogleFonts.quicksand(
                        color: isEnabledOS
                            ? Colors.grey // Grey out the text
                            : selectedTheme.colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(), // Push the second text to the end
                    Text(
                      currentThemeName,
                      //  "Current Theme: $currentThemeName",
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedTheme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Themes explanation
            Padding(
              padding: const EdgeInsets.only(
                  left: 70), // Set your desired padding here
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "(Turn off OS enabled light/dark mode to set\n a theme.)",
                  style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: isEnabledOS
                          ? Colors.grey
                          : selectedTheme.colorScheme.primary,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
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
                      'Change password',
                      style: GoogleFonts.quicksand(
                        color: selectedTheme.colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                    style: GoogleFonts.quicksand(
                      color: selectedTheme.colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ), // Merge styles with GoogleFonts
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
