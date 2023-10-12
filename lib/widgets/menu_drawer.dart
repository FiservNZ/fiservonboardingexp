import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fiservonboardingexp/screens/menu drawer/feedback_page.dart';
import '../util/constants.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    var iconTextColor = selectedTheme.colorScheme.secondary;
    var padding = const EdgeInsets.only(left: 10, right: 10);

    return SafeArea(
      child: Container(
        height: 400,
        color: selectedTheme.colorScheme.tertiary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tab design at the top of the menu drawer
              Container(
                decoration: BoxDecoration(
                  color: iconTextColor, // Color of the rounded rectangle
                  borderRadius: BorderRadius.circular(
                      10), // Adjust the radius for desired roundness
                ),
                height: 6, // Adjust the height of the rectangle as needed
                width: 40, // Make it span the entire width
              ),

              const SizedBox(height: 10),

              //Intro teaser
              Container(
                padding: padding,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.list,
                        color: iconTextColor,
                      ),
                      title: Text(
                        'Intro Teaser',
                        style: GoogleFonts.quicksand(
                          color: iconTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.toNamed("/teaser");
                      },
                      trailing: Text(
                        '>',
                        style: TextStyle(
                            fontSize: 18,
                            color: iconTextColor,
                            fontWeight: FontWeight.bold),
                      ), // Add left arrow icon here
                    ),
                  ],
                ),
              ),

              // Help pop up
              Container(
                padding: padding,
                child: ListTile(
                  leading: Icon(
                    Icons.question_mark,
                    color: iconTextColor,
                  ),
                  title: Text(
                    'Help',
                    style: GoogleFonts.quicksand(
                      color: iconTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.toNamed("/help");
                  },
                  trailing: Text('>',
                      style: TextStyle(
                          fontSize: 18,
                          color: iconTextColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),

              // FAQ
              Container(
                padding: padding,
                child: ListTile(
                  leading: Icon(
                    Icons.question_answer,
                    color: iconTextColor,
                  ),
                  title: Text(
                    'FAQ',
                    style: GoogleFonts.quicksand(
                      color: iconTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ), // Merge styles with GoogleFonts
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.toNamed("/faq");
                  },
                  trailing: Text('>',
                      style: TextStyle(
                          fontSize: 18,
                          color: iconTextColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),

              // Settings
              Container(
                padding: padding,
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: iconTextColor,
                  ),
                  title: Text(
                    'Settings',
                    style: GoogleFonts.quicksand(
                      color: iconTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ), // Merge styles with GoogleFonts
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.toNamed("/settings");
                  },
                  trailing: Text('>',
                      style: TextStyle(
                          fontSize: 18,
                          color: iconTextColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),

              // Feedback
              Container(
                padding: padding,
                child: ListTile(
                  leading: Icon(
                    Icons.feedback_outlined,
                    color: iconTextColor,
                  ),
                  title: Text(
                    'Feedback',
                    style: GoogleFonts.quicksand(
                      color: iconTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ), // Merge styles with GoogleFonts
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const FeedBack()),
                    );
                  },
                  trailing: Text('>',
                      style: TextStyle(
                          fontSize: 18,
                          color: iconTextColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 10),

              //Logout Button
              //Padding(
              // padding:
              //     EdgeInsets.only(left: 0), // Adjust the left padding as needed
              // child:
              SizedBox(
                width: 150, // Set the desired width for the button
                child: ElevatedButton(
                  onPressed: () async {
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor:
                              selectedTheme.colorScheme.onBackground,
                          title: Text(
                            'Confirmation',
                            style: TextStyle(
                              color: selectedTheme.colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ).merge(GoogleFonts.quicksand()),
                          ),
                          content: Text(
                            "Are you sure you want to Logout?",
                            style: TextStyle(
                              color: selectedTheme.colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ).merge(GoogleFonts.quicksand()),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // User clicked No, close the dialog and don't log them out.
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: selectedTheme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ).merge(GoogleFonts.quicksand()),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // User clicked Yes, close the dialogue and log them out.
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: selectedTheme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ).merge(GoogleFonts.quicksand()),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirm == true) {
                      await FirebaseAuth.instance.signOut();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTheme
                        .colorScheme.secondary, // Button background color
                    foregroundColor:
                        selectedTheme.colorScheme.tertiary, // Text color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: selectedTheme.colorScheme.tertiary,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Log Out',
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
