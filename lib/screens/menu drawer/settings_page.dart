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
  bool isOSmode = false;

  @override
  void initState() {
    super.initState();
    _loadOSMode();
  }

  // Retrieves the disabled or enabled variable for the OS mode
  Future<void> _loadOSMode() async {
    final osMode = await _firebaseTheme.getOSPreference(currentUser.uid);
    // Provide a default value (e.g., false) if osMode is null
    isOSmode = osMode ?? false;
    setState(() {});
  }

  double edgePadding = 30;
  double iconTxtSpacing = 15;
  double listSpacing = 25;
  bool isdisabled = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    //Obtains the current light/dark mode of the OS setting.
    var brightness = MediaQuery.of(context).platformBrightness;

    // Text to indicate the theme
    String currentThemeName = 'None';
    if (selectedTheme == rainforestTheme) {
      currentThemeName = 'Rainforest';
    } else if (selectedTheme == pastelTheme) {
      currentThemeName = 'Pastel';
    } else if (selectedTheme == beachTheme) {
      currentThemeName = 'Beach';
    }

    // Text to indicate the mode
    String currentMode = 'Off';
    if (isOSmode == true) {
      currentMode = 'Off';
    } else {
      if (selectedTheme == lightTheme) {
        currentMode = 'Light';
      } else if (selectedTheme == darkTheme) {
        currentMode = 'Dark';
      }
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
                Icon(
                  Icons.lightbulb,
                  color: isOSmode
                      ? selectedTheme.colorScheme.primary
                      : Colors.grey,
                ),
                SizedBox(
                    width: iconTxtSpacing), // Add spacing between icon and text
                Text(
                  'OS enabled light/\ndark mode',
                  style: GoogleFonts.quicksand(
                    color: isOSmode
                        ? selectedTheme.colorScheme.primary
                        : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 60),
                    Switch(
                      value: isOSmode,
                      onChanged: (value) async {
                        setState(() {
                          isOSmode = value;
                          if (brightness == Brightness.light) {
                            themeProvider.setTheme(lightTheme);
                          } else {
                            themeProvider.setTheme(darkTheme);
                          }
                        });
                        // Saves the OS mode preference
                        _firebaseTheme.saveOSPreference(
                            currentUser.uid, isOSmode);
                      },
                      activeColor: selectedTheme.colorScheme.primary,
                    ),
                    Text(
                      isOSmode ? 'On' : 'Off',
                      style: GoogleFonts.quicksand(
                        color: isOSmode
                            ? selectedTheme.colorScheme.primary
                            : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 6),

            // OS controlled light/dark mode explanation
            Padding(
              padding: const EdgeInsets.only(
                  left: 71), // Set your desired padding here
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "(Enabling this feature allows the app mode to\n be controlled by your phone's dark/light\n mode settings..)",
                  style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: isOSmode
                          ? selectedTheme.colorScheme.primary
                          : Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Light and Dark mode
            Row(
              children: [
                SizedBox(width: edgePadding),
                Icon(
                  Icons.lightbulb,
                  color: isOSmode
                      ? Colors.grey // Grey out the icon
                      : selectedTheme.colorScheme.primary,
                ),
                SizedBox(
                  width: iconTxtSpacing,
                ),
                Text(
                  'Light/dark mode', // Display "Light/Dark Mode On"
                  style: GoogleFonts.quicksand(
                    color: isOSmode
                        ? Colors.grey // Grey out the text
                        : selectedTheme.colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 63),
                Switch(
                  value: selectedTheme == lightTheme,
                  onChanged: (isOSmode)
                      ? null
                      : (value) {
                          if (value) {
                            themeProvider.setTheme(lightTheme);
                            // Save the selected theme mode to Firebase Firestore
                            _firebaseTheme.saveThemePreference(
                                currentUser.uid, lightTheme);
                          } else {
                            themeProvider.setTheme(darkTheme);
                            // Save the selected theme mode to Firebase Firestore
                            _firebaseTheme.saveThemePreference(
                                currentUser.uid, darkTheme);
                          }
                        },
                  activeColor: selectedTheme.colorScheme.primary,
                ),
                Text(
                  currentMode,
                  //  "Current Mode: $currentMode",
                  style: TextStyle(
                    fontSize: 14,
                    color: isOSmode
                        ? Colors.grey
                        : selectedTheme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            //  light/dark mode explanation
            Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Align(
                child: Text(
                  "(Turn off OS enabled light/dark mode to set\n the mode.)",
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    color: isOSmode
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
            InkWell(
              onTap: () {
                if (!isOSmode) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ThemesPage();
                  }));
                }
              },
              child: Container(
                height: 30,
                margin: EdgeInsets.symmetric(horizontal: edgePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.color_lens,
                          color: isOSmode
                              ? Colors.grey // Grey out the icon
                              : selectedTheme.colorScheme.primary,
                        ),
                        SizedBox(
                          width: iconTxtSpacing,
                        ), // Add some spacing between icon and text
                        Text(
                          'Themes',
                          style: GoogleFonts.quicksand(
                            color: isOSmode
                                ? Colors.grey // Grey out the text
                                : selectedTheme.colorScheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 157),

                        Text(
                          currentThemeName,
                          //  "Current Theme: $currentThemeName",
                          style: TextStyle(
                            fontSize: 14,
                            color: isOSmode
                                ? Colors.grey
                                : selectedTheme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Themes explanation
            InkWell(
              onTap: () {
                if (!isOSmode) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ThemesPage();
                  }));
                }
              },
              child: Container(
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 70), // Set your desired padding here
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "(Turn off OS enabled light/dark mode to set a\n theme.)",
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        color: isOSmode
                            ? Colors.grey
                            : selectedTheme.colorScheme.primary,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Change password
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ChangePasswordPage();
                }));
              },
              child: Container(
                height: 30,
                margin: EdgeInsets.symmetric(horizontal: edgePadding),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.change_circle_outlined,
                      color: selectedTheme.colorScheme.primary,
                    ),
                    SizedBox(
                      width: iconTxtSpacing,
                    ), // Add some spacing between icon and text
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
