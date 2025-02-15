import 'package:fiservonboardingexp/themes/quiz%20themes/ui_parameters.dart';
import 'package:flutter/material.dart';

class TasksScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const TasksScreenAppBar({
    super.key,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 100, vertical: mobileScreenPadding),
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
