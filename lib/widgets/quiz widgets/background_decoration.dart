import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import '../../themes/quiz themes/app_colors.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;
  final bool showGradient;

  const BackgroundDecoration(
      {super.key, required this.child, this.showGradient = false});

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
              color:
                  showGradient ? null : selectedTheme.colorScheme.onBackground,
              gradient: showGradient ? mainGradient() : null),
        )),
        Positioned(child: SafeArea(child: child))
      ],
    );
  }
}
