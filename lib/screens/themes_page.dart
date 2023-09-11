import 'package:fiservonboardingexp/themes/dark_theme.dart';
import 'package:fiservonboardingexp/themes/light_theme.dart';
import 'package:fiservonboardingexp/themes/pastel_theme.dart';
import 'package:fiservonboardingexp/themes/rainforest_theme.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/widgets/app_bar_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemesPage extends StatelessWidget {
  const ThemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    void _handleThemeChange(ThemeData theme) {
      themeProvider.setTheme(theme);
    }

    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Select a Theme:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            //Light theme
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: selectedTheme
                    .colorScheme.primary, // Set the unselected icon color
              ),
              child: RadioListTile<ThemeData>(
                title: Text(
                  'Light Theme',
                  style: TextStyle(color: selectedTheme.colorScheme.primary),
                ),
                value: lightTheme,
                groupValue: selectedTheme,
                onChanged: (value) {
                  _handleThemeChange(lightTheme);
                },
              ),
            ),

            //Dark theme
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: selectedTheme
                    .colorScheme.primary, // Set the unselected icon color
              ),
              child: RadioListTile<ThemeData>(
                title: Text(
                  'Dark Theme',
                  style: TextStyle(color: selectedTheme.colorScheme.primary),
                ),
                value: darkTheme,
                groupValue: selectedTheme,
                onChanged: (value) {
                  _handleThemeChange(darkTheme);
                },
              ),
            ),

            // Rainforest theme
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: selectedTheme
                    .colorScheme.primary, // Set the unselected icon color
              ),
              child: RadioListTile<ThemeData>(
                title: Text(
                  'Rainforest Theme',
                  style: TextStyle(color: selectedTheme.colorScheme.primary),
                ),
                value: rainforestTheme,
                groupValue: selectedTheme,
                onChanged: (value) {
                  _handleThemeChange(rainforestTheme);
                },
                activeColor: selectedTheme
                    .colorScheme.primary, // Set the selected icon color
              ),
            ),

            // Pastel theme
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: selectedTheme
                    .colorScheme.primary, // Set the unselected icon color
              ),
              child: RadioListTile<ThemeData>(
                title: Text(
                  'Pastel Theme',
                  style: TextStyle(color: selectedTheme.colorScheme.primary),
                ),
                value: pastelTheme,
                groupValue: selectedTheme,
                onChanged: (value) {
                  _handleThemeChange(pastelTheme);
                },
                activeColor: selectedTheme
                    .colorScheme.primary, // Set the selected icon color
              ),
            ),

            const SizedBox(height: 150),

            // Apply button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    selectedTheme.colorScheme.secondary,
                  ),
                ),
                child: Text(
                  'Apply Theme',
                  style: TextStyle(color: selectedTheme.colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
