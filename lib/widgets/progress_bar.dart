import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../util/constants.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: LinearPercentIndicator(
          lineHeight: 20,
          percent: 0.5,
          progressColor: fiservColor,
          backgroundColor: Color.fromARGB(193, 238, 192, 106)),
    );
  }
}
