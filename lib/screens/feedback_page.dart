import 'package:flutter/material.dart';
import '../util/constants.dart';
import '../widgets/app_bar_overlay.dart';
import '../widgets/faq_list.dart';
import '../widgets/star_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_screen.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  int userRating = 0;
  String userFeedback = '';
  bool isRatingSelected = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Fiserv Application Feedback",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 21,
            color: Colors.white,
          ),
        ),
        backgroundColor: fiservColor,
      ),
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: SingleChildScrollView(
        // Wrap your Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Congratulations, you have completed the onboarding journey!",
                style: GoogleFonts.quicksand(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "How do you rate this app?",
                style: GoogleFonts.quicksand(
                  // Set the font to Quicksand
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              StarRating(
                onRatingChanged: (rating) {
                  setState(() {
                    userRating = rating;
                    isRatingSelected = true;
                    print("Selected rating: $rating");
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Enter your feedback:",
                style: GoogleFonts.quicksand(
                  // Set the font to Quicksand
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: _feedbackController,
                  onChanged: (text) {
                    setState(() {
                      userFeedback = text;
                    });
                  },
                  // Writing field for user feedback
                  decoration: InputDecoration(
                    hintText: 'Type your feedback here',
                    hintStyle: GoogleFonts.quicksand(
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                  ),
                  maxLines: 10,
                  style: TextStyle(
                      color: Colors
                          .white), // User typing font colour CHANGE HERE @@@@@@@@@
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ElevatedButton(
                  onPressed: isRatingSelected
                      ? () async {
                          // Store rating and feedback in firebase
                          await FirebaseFirestore.instance
                              .collection('Feedback') // Collection Name
                              .add({
                            'rating': userRating,
                            'feedback': userFeedback,
                            'timestamp': FieldValue.serverTimestamp(),
                          });

                          // Little output on the bottom after the user submits the feedback
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Thank you for your feedback!'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MainScreen(), // Replace with your MainScreen widget
                            ),
                          );

                          // Debugging to check if it's being stored
                          print("Storing rating in Firebase: $userRating");
                          print("Storing feedback in Firebase: $userFeedback");
                        }
                      : null, // Disable button if the star rating is not selected
                  child: Container(
                    width: double.infinity,
                    child: Center(
                      child: Text("Submit Feedback",
                          style: TextStyle(fontSize: 16)), // Submit Button
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
      ),
    );
  }
}
