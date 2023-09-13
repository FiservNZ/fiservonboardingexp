import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../util/elle_testing/themes/app_colors.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;
  final bool showGradient;

  const BackgroundDecoration(
      {super.key, required this.child, this.showGradient = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
              color: showGradient ? null : darkBackgroundColor,
              //color: showGradient ? null : Theme.of(context).primaryColor,
              gradient: showGradient ? mainGradient() : null),
        )),
        Positioned(child: SafeArea(child: child))
      ],
    );
  }
}
