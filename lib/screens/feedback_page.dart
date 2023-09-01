import 'package:flutter/material.dart';
import '../util/constants.dart';
import '../widgets/app_bar_overlay.dart';
import '../widgets/faq_list.dart';
import '../widgets/star_rating.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  int userRating = 0;
  String userFeedback = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Fiserv Application Feedback",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
        backgroundColor: fiservColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Congratulations, you have completed the onboarding journey!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "How do you rate this app?",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            StarRating(
              onRatingChanged: (rating) {
                setState(() {
                  userRating = rating;
                  print("Selected rating: $rating");
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter your feedback:",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    userFeedback = text;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Type your feedback here',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                ),
                maxLines: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: ElevatedButton(
                onPressed: () {
                  // Store userRating and userFeedback in Firebase
                  print("Storing rating in Firebase: $userRating");
                  print("Storing feedback in Firebase: $userFeedback");
                },
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child:
                        Text("Submit Feedback", style: TextStyle(fontSize: 16)),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  backgroundColor: fiservColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
