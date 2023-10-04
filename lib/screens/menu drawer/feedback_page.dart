import 'package:fiservonboardingexp/screens/achievements_page.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/star_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main_screen.dart';

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
  final Achievementpage _achievementpage = Achievementpage();
  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Fiserv Application Feedback",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 21,
            color: selectedTheme.colorScheme.secondary,
          ),
        ),
        backgroundColor: selectedTheme.colorScheme.tertiary,
      ),
      backgroundColor: selectedTheme.colorScheme.background,
      // SingleChildScrollView was used to get rid of pixel overflow
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text on the top of the feedback screen
              Text(
                "Tell us what you love about the app, or what we could be doing better!",
                style: GoogleFonts.quicksand(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: selectedTheme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "How do you rate this app?",
                style: GoogleFonts.quicksand(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: selectedTheme.colorScheme.primary,
                ),
              ),
              // Star Rating Class to get the star rating system (5 stars)
              StarRating(
                onRatingChanged: (rating) {
                  // Updates the star depending on what the user has selected
                  setState(() {
                    userRating = rating;
                    isRatingSelected = true;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Enter your feedback:",
                style: GoogleFonts.quicksand(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: selectedTheme.colorScheme.primary,
                ),
              ),
              // Text field for user feedback written input
              Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: _feedbackController,
                  onChanged: (text) {
                    setState(() {
                      userFeedback = text;
                    });
                  },
                  // Prompt in the text field above ^ for user feedback field, disappears when user types
                  decoration: InputDecoration(
                    hintText: 'Type your feedback here',
                    hintStyle: GoogleFonts.quicksand(
                      color: Colors.grey,
                    ),
                    // Feedback textfield outline border
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                  ),
                  maxLines:
                      10, // You can make the feedback text field bigger here
                  style: const TextStyle(
                      // color: selectedTheme.colorScheme
                      //     .primary
                      ),
                  // User typing font colour CHANGE HERE
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: GestureDetector(
                  onTap: isRatingSelected
                      ? () async {
                          // Store rating and feedback in Firebase
                          await FirebaseFirestore.instance
                              .collection('Feedback')
                              .add({
                            'rating': userRating,
                            'feedback': userFeedback,
                            'timestamp': FieldValue.serverTimestamp(),
                          });
                          // Update the achievement
                          // ignore: use_build_context_synchronously
                          _achievementpage.updateAchievement(
                              context, "Submitted feedback!");

                          // Little output on the bottom after the user submits the feedback
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Thank you for your feedback!'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );

                          // Debugging to check if it's being stored
                          print("Storing rating in Firebase: $userRating");
                          print("Storing feedback in Firebase: $userFeedback");
                        }
                      : null,
                  child: SizedBox(
                    width: double.infinity,
                    height: 40, // Set the desired height here
                    child: Container(
                      decoration: BoxDecoration(
                        color: isRatingSelected
                            ? selectedTheme.colorScheme.onBackground
                            : selectedTheme.colorScheme.onSurface,
                        // Change the color when disabled
                      ),
                      child: Center(
                        child: Text(
                          "Submit Feedback",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isRatingSelected
                                  ? selectedTheme.colorScheme.secondary
                                  : selectedTheme.colorScheme.onPrimary),
                        ),
                      ),
                    ),
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
