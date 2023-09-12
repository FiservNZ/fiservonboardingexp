import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

// This class creates a row of star icons for the user rating
class StarRating extends StatefulWidget {
  final Function(int) onRatingChanged;

  StarRating({required this.onRatingChanged});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    // Star rating system implementation here
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final star = index + 1;
        return Expanded(
          child: IconButton(
            icon: Icon(
              _rating >= star ? Icons.star : Icons.star_border,
              color: fiservColor,
              size: 45.0,
            ),
            onPressed: () {
              // Updates the rating here
              setState(() {
                _rating = star;
                widget.onRatingChanged(_rating);
              });
            },
          ),
        );
      }),
    );
  }
}
