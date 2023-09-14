import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:fiservonboardingexp/themes/Theme_database.dart';
import 'package:fiservonboardingexp/themes/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme;

  // Initializes the theme
  ThemeProvider() {
    _currentTheme = lightTheme; // Set a default theme
    getTheme().then((themeData) {
      _currentTheme = themeData ??
          lightTheme; // Use the fetched theme or default to lightTheme
      notifyListeners();
    });
  }

  ThemeData get currentTheme => _currentTheme;

  // Method to obtain the User's theme from Firebase
  Future<ThemeData> getTheme() async {
    if (currentUser != null) {
      // Saves the theme into a variable after gettting it from Firebase
      final stringThemeData =
          await ThemeDatabase().getThemePreference(currentUser.uid);
      if (stringThemeData != null) {
        // Converts the theme into a themeData so it can be used
        final themeData = stringToThemeData(stringThemeData);
        return themeData;
      }
    }

    // If no theme preference is found or there is no authenticated user, return light theme
    return lightTheme;
  }

  // Method to change theme
  Future<void> setTheme(ThemeData theme) async {
    _currentTheme = theme;
    // Notify listeners about the theme change
    notifyListeners();
  }
}
