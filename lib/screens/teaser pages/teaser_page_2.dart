import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class TeaserPage2 extends StatefulWidget {
  @override
  _TeaserPage2State createState() => _TeaserPage2State();
}

class _TeaserPage2State extends State<TeaserPage2> {
  int _currentPage = 0;
  late Timer _timer;

  List<String> imagePaths = [
    'assets/images/beach.png',
    'assets/images/pastel.png',
    'assets/images/forest.png',
  ];

  @override
  void initState() {
    super.initState();

    // Timer to change teaser page every 1 second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 194, 200, 255),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top:
                  90.0), // Adjustment of the Text title and subtext (vertically)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: Image.asset(
                    imagePaths[_currentPage],
                    key: ValueKey<int>(_currentPage),
                    width: 350,
                    height: 450,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                'Unlock Rewards!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 81, 0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 20, 10),
                child: Text(
                  'Complete modules to gain more experience! Unlock more icons and themes by gaining experience and leveling!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
