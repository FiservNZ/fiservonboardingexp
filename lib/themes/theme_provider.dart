import 'package:fiservonboardingexp/themes/Theme_database.dart';
import 'package:fiservonboardingexp/themes/dark_theme.dart';
import 'package:fiservonboardingexp/themes/light_theme.dart';
import 'package:flutter/material.dart';
import '../firebase references/firebase_refs.dart';
import 'dart:async';

class ThemeProvider extends ChangeNotifier {
  final BuildContext context;
  ThemeData _currentTheme = lightTheme;
  Brightness _currentOsBrightness = Brightness.light;
  bool? isOSmode;

  // Initialize a timer so it will dynamically update if the os theme is changed.
  late Timer _themeUpdateTimer;

  // Initializes the theme when the app starts up.
  ThemeProvider(this.context, {bool? isOSmode}) {
    // Initialize isOSmode with the provided value or set a default value.
    this.isOSmode = isOSmode ?? false;
    initializeTheme();
    startOsThemeChangeTimer(); // Start the timer
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

    // Gets the current OS theme.
    var brightness = MediaQuery.of(context).platformBrightness;
    _currentOsBrightness = brightness;

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

// Start the timer to periodically check for OS theme changes
  void startOsThemeChangeTimer() {
    _themeUpdateTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final newBrightness = MediaQuery.of(context).platformBrightness;

      if (newBrightness != _currentOsBrightness) {
        // OS brightness has changed, update the app's theme
        _currentOsBrightness = newBrightness;

        // Determine and set the new theme based on the updated brightness
        final theme =
            _currentOsBrightness == Brightness.dark ? darkTheme : lightTheme;

        setTheme(theme);
      }
    });
  }

  // Cancel the timer when the provider is disposed
  @override
  void dispose() {
    _themeUpdateTimer.cancel();
    super.dispose();
  }
}
