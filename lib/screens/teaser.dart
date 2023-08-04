import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'home_page.dart';
import 'teaser_page_1.dart';
import 'teaser_page_2.dart';
import 'teaser_page_3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:after_layout/after_layout.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TeaserScreen extends StatefulWidget {
  const TeaserScreen({Key? key}) : super(key: key);

  @override
  _TeaserScreenState createState() => _TeaserScreenState();
}

class _TeaserScreenState extends State<TeaserScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            TeaserPage1(),
            TeaserPage2(),
            TeaserPage3(),
          ],
        ),
        Container(
          alignment: Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: const Text('Skip'),
                onTap: () {
                  _controller.jumpToPage(2);
                },
              ),
              SmoothPageIndicator(controller: _controller, count: 3),
              onLastPage
                  ? GestureDetector(
                      child: const Text('Done'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MainScreen(),
                          ),
                        );
                      },
                    )
                  : GestureDetector(
                      child: const Text('Next'),
                      onTap: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                    ),
            ],
          ),
        ),
      ],
    ));
  }
}
