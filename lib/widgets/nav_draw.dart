import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fiservonboardingexp/screens/menu drawer/feedback_page.dart';
import '../util/constants.dart';
import 'package:fiservonboardingexp/screens/Login_page.dart';

class NavDraw extends StatelessWidget {
  const NavDraw({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    var iconTextColor = selectedTheme.colorScheme.secondary;
    var navDrawTileColor = selectedTheme.colorScheme.onBackground;

    return Container(
      height: 600,
      color: selectedTheme.colorScheme.tertiary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: navDrawTileColor, // Color of the rounded rectangle
                borderRadius: BorderRadius.circular(
                    10), // Adjust the radius for desired roundness
              ),
              height: 6, // Adjust the height of the rectangle as needed
              width: 40, // Make it span the entire width
            ),

            const SizedBox(height: 15),

            //Intro teaser
            Container(
              decoration: BoxDecoration(
                color: navDrawTileColor, // Background color for the entire menu
              ),
              child: Column(
                children: [
                  ListTile(
                    tileColor:
                        Colors.white, // Background color for this ListTile
                    leading: Icon(
                      Icons.list,
                      color: iconTextColor,
                    ),
                    title: Text(
                      'Intro Teaser',
                      style: TextStyle(
                        color: iconTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ).merge(GoogleFonts.quicksand()),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.toNamed("/teaser");
                    },
                    trailing: Text(
                      '>',
                      style: TextStyle(fontSize: 18, color: iconTextColor),
                    ), // Add left arrow icon here
                  ),
                ],
              ),
            ),

            // Help pop up
            Container(
              decoration: BoxDecoration(
                color: navDrawTileColor,
              ),
              child: ListTile(
                tileColor: Colors.white, // Background color for this ListTile
                leading: Icon(
                  Icons.question_mark,
                  color: iconTextColor,
                ),
                title: Text(
                  'Help',
                  style: TextStyle(
                    color: iconTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ).merge(GoogleFonts.quicksand()),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed("/help");
                },
                trailing: Text('>',
                    style: TextStyle(fontSize: 18, color: iconTextColor)),
              ),
            ),

            // FAQ
            Container(
              decoration: BoxDecoration(
                color: navDrawTileColor,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: iconTextColor,
                ),
                title: Text(
                  'FAQ',
                  style: TextStyle(
                    color: iconTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ).merge(
                      GoogleFonts.quicksand()), // Merge styles with GoogleFonts
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed("/faq");
                },
                trailing: Text('>',
                    style: TextStyle(fontSize: 18, color: iconTextColor)),
              ),
            ),

            // Settings
            Container(
              decoration: BoxDecoration(
                color: navDrawTileColor,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: iconTextColor,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color: iconTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ).merge(
                      GoogleFonts.quicksand()), // Merge styles with GoogleFonts
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed("/settings");
                },
                trailing: Text('>',
                    style: TextStyle(fontSize: 18, color: iconTextColor)),
              ),
            ),

            // Feedback
            Container(
              decoration: BoxDecoration(
                color: navDrawTileColor,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.feedback_outlined,
                  color: iconTextColor,
                ),
                title: Text(
                  'Feedback',
                  style: TextStyle(
                    color: iconTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ).merge(
                      GoogleFonts.quicksand()), // Merge styles with GoogleFonts
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FeedBack()),
                  );
                },
                trailing: Text('>',
                    style: TextStyle(fontSize: 18, color: iconTextColor)),
              ),
            ),

            const SizedBox(height: 25),

            //Logout Button
            Container(
              decoration: BoxDecoration(
                color: navDrawTileColor, // Background color
                // border: Border.all(
                //   color: Color.fromARGB(
                //       255, 77, 76, 76), // Border color
                //   width: 2.0, // Border width
                // ),
                //borderRadius: BorderRadius.circular(
                //    20.0), // Border radius if needed
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: selectedTheme.colorScheme.secondary,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        color: selectedTheme.colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ).merge(GoogleFonts.quicksand()),
                    ),
                  ],
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  var scaffoldKey;
                  Navigator.of(scaffoldKey.currentContext!, rootNavigator: true)
                      .pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return LoginPage();
                      },
                    ),
                    (_) => false,
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
