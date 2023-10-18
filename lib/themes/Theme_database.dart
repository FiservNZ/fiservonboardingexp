import 'package:fiservonboardingexp/themes/beach_theme.dart';
import 'package:fiservonboardingexp/themes/dark_theme.dart';
import 'package:fiservonboardingexp/themes/light_theme.dart';
import 'package:fiservonboardingexp/themes/pastel_theme.dart';
import 'package:fiservonboardingexp/themes/rainforest_theme.dart';
import 'package:flutter/material.dart';
import '../firebase references/firebase_refs.dart';

// Converts the the themeData to a String so it can be saved into Firebase.
String themeDataToString(ThemeData theme) {
  if (theme == lightTheme) {
    return 'light';
  } else if (theme == darkTheme) {
    return 'dark';
  } else if (theme == pastelTheme) {
    return 'pastel';
  } else if (theme == rainforestTheme) {
    return 'rainforest';
  } else if (theme == beachTheme) {
    return 'beach';
  }
  // Handle any other themes here.
  return 'light'; // Default theme if none of the above matches.
}

// Converts the String to a themeData so that the theme provider can use it.
ThemeData stringToThemeData(String theme) {
  if (theme == 'light') {
    return lightTheme;
  } else if (theme == 'dark') {
    return darkTheme;
  } else if (theme == 'pastel') {
    return pastelTheme;
  } else if (theme == 'rainforest') {
    return rainforestTheme;
  } else if (theme == 'beach') {
    return beachTheme;
  } else {
    // Return a default theme.
    return lightTheme;
  }
}

class ThemeDatabase {
  // Method to save chosen theme
  Future<void> saveThemePreference(String userId, ThemeData theme) async {
    final themeName = themeDataToString(theme); // Convert theme to a string.
    await firestore.collection('User').doc(userId).update(
        {'theme': themeName}); // Saves in Firestore for the current user.
  }

  // Method to retrieve theme from Firestore.
  Future<String?> getThemePreference(String userId) async {
    final userData = await userColRef.doc(userId).get();
    return userData['theme'] as String;
  }

  // Saves the OS mode as enable or disabled.
  Future<void> saveOSPreference(String userId, bool isOSmode) async {
    await firestore
        .collection('User')
        .doc(userId)
        .update({'isOSmode': isOSmode});
  }

  // Retrieves the variable for the os mode
  Future<bool?> getOSPreference(String userId) async {
    final userData = await userColRef.doc(userId).get();
    return userData['isOSmode'] as bool?;
  }
}
