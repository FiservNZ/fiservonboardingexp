import 'teaser_page_1.dart';
import 'teaser_page_2.dart';
import 'teaser_page_3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TeaserScreen extends StatefulWidget {
  const TeaserScreen({Key? key}) : super(key: key);

  @override
  TeaserScreenState createState() => TeaserScreenState();
}

class TeaserScreenState extends State<TeaserScreen> {
  final PageController _controller = PageController();
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
          // Loads three teaser pages
          children: const [
            TeaserPage1(),
            TeaserPage2(),
            TeaserPage3(),
          ],
        ),
        // Skip, done and next button implementation here
        Container(
          alignment: const Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // When the user presses skip, it directs the user to the last teaser page which is on page 2.
            children: [
              GestureDetector(
                child: const Text('Skip'),
                onTap: () {
                  _controller.jumpToPage(2);
                },
              ),
              SmoothPageIndicator(controller: _controller, count: 3),
              // When the user presses done, it directs the user out of the teaser.
              onLastPage
                  ? GestureDetector(
                      child: const Text('Done'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  // When the user presses next, it goes to the next teaser screen
                  : GestureDetector(
                      child: const Text('Next'),
                      onTap: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves
                                .easeIn); // Animation for going to the next teaser page
                      },
                    ),
            ],
          ),
        ),
      ],
    ));
  }
}
