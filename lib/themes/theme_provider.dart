import 'package:fiservonboardingexp/themes/Theme_database.dart';
import 'package:fiservonboardingexp/themes/dark_theme.dart';
import 'package:fiservonboardingexp/themes/light_theme.dart';
import 'package:flutter/material.dart';
import '../firebase references/firebase_refs.dart';

class ThemeProvider extends ChangeNotifier {
  final BuildContext context;
  ThemeData _currentTheme = lightTheme;

  // Initializes the theme when the app starts up.
  ThemeProvider(this.context) {
    initializeTheme();
  }

  Future<void> initializeTheme() async {
    final themeData = await getTheme();
    _currentTheme = themeData;
    notifyListeners();
  }

  ThemeData get currentTheme => _currentTheme;

  // Method to obtain the User's theme from Firebase.
  Future<ThemeData> getTheme() async {
    final bool? isOSmode =
        await ThemeDatabase().getOSPreference(currentUser.uid);
    var brightness = MediaQuery.of(context).platformBrightness;

    if (isOSmode == true) {
      // Use OS-controlled mode
      if (brightness == Brightness.dark) {
        return darkTheme;
      } else {
        return lightTheme;
      }
    } else {
      // Use the theme from Firebase
      final stringThemeData =
          await ThemeDatabase().getThemePreference(currentUser.uid);
      if (stringThemeData != null) {
        final themeData = stringToThemeData(stringThemeData);
        return themeData;
      }
    }
    // Default theme if nothing matches
    return lightTheme;
  }

  // Method to change theme
  Future<void> setTheme(ThemeData theme) async {
    _currentTheme = theme;
    // Notify listeners about the theme change.
    notifyListeners();
  }
}
