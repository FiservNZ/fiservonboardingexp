import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/themes/beach_theme.dart';
import 'package:fiservonboardingexp/themes/dark_theme.dart';
import 'package:fiservonboardingexp/themes/light_theme.dart';
import 'package:fiservonboardingexp/themes/pastel_theme.dart';
import 'package:fiservonboardingexp/themes/rainforest_theme.dart';
import 'package:flutter/material.dart';

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
  // Handle any other themes here
  return 'light'; // Default theme if none of the above matches
}

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
    // Return a default theme (you can customize this)
    return lightTheme;
  }
}

class ThemeDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveThemePreference(String userId, ThemeData theme) async {
    final themeName = themeDataToString(theme); // Convert theme to a string
    await _firestore
        .collection('User')
        .doc(userId)
        .update({'theme': themeName});
  }

  Future<String?> getThemePreference(String userId) async {
    final userData = await _firestore.collection('User').doc(userId).get();
    return userData['theme'] as String;
  }
}
