import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/themes/Theme_database.dart';
import 'package:fiservonboardingexp/themes/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme;

  ThemeProvider() {
    // Initialize the theme when the provider is created
    _currentTheme = lightTheme; // Set a default theme
    getTheme().then((themeData) {
      _currentTheme = themeData ??
          lightTheme; // Use the fetched theme or default to lightTheme
      notifyListeners();
    });
  }

  ThemeData get currentTheme => _currentTheme;

  Future<ThemeData> getTheme() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final stringThemeData =
          await ThemeDatabase().getThemePreference(currentUser.uid);
      if (stringThemeData != null) {
        final themeData = stringToThemeData(stringThemeData);
        return themeData;
      }
    }

    // If no theme preference is found or there is no authenticated user, return light theme
    return lightTheme;
  }

  Future<void> setTheme(ThemeData theme) async {
    _currentTheme = theme;
    // Notify listeners about the theme change
    notifyListeners();
  }
}
