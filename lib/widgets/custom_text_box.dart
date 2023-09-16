import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextBox extends StatelessWidget {
  final String text;
  final String fieldName;
  final void Function()? onPressed;
  const CustomTextBox({
    super.key,
    required this.text,
    required this.fieldName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    return Container(
      decoration: BoxDecoration(
        color: selectedTheme.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                fieldName,
                style: TextStyle(
                  color: selectedTheme.colorScheme.secondary,
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.edit),
                color: selectedTheme.colorScheme.secondary,
              ),
            ],
          ),
          Text(
            text,
            style: TextStyle(color: selectedTheme.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
