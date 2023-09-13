import 'package:fiservonboardingexp/util/elle_testing/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

import '../../util/constants.dart';

class ContentArea extends StatelessWidget {
  final bool addPadding;
  final Widget child;

  const ContentArea({super.key, this.addPadding = true, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(color: darkBackgroundColor),
        padding: addPadding
            ? EdgeInsets.only(
                top: mobileScreenPadding,
                left: mobileScreenPadding,
                right: mobileScreenPadding)
            : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
