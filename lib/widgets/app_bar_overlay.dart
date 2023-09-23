import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/screens/Login_page.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../firebase references/firebase_refs.dart';
import '../screens/menu drawer/feedback_page.dart';

class AppBarOverlay extends StatelessWidget implements PreferredSizeWidget {
  const AppBarOverlay({super.key, User? currentUser});

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    var iconTextColor = selectedTheme.colorScheme.secondary;
    var navDrawTileColor = selectedTheme.colorScheme.onBackground;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    // Update the current user account
    final currentUser = FirebaseAuth.instance.currentUser;
    final rankTitleMap = {
      1: 'Novice 1',
      2: 'Novice 2',
      3: 'Novice 3',
      4: 'Novice 4',
      5: 'Novice 5',
      6: 'Novice 6',
      7: 'Novice 7',
      8: 'Novice 8',
      9: 'Novice 9'
    };

    // Check if currentUser is null and handle accordingly
    if (currentUser == null) {
      // You can return a loading indicator or an empty AppBar here
      return AppBar(
        backgroundColor: selectedTheme.colorScheme.tertiary,
        elevation: 0.0,
        title: const Center(
          child: CircularProgressIndicator(), // Display a loading indicator
        ),
      );
    }

    return SafeArea(
      key: scaffoldKey,
      child: AppBar(
        backgroundColor: selectedTheme.colorScheme.tertiary,
        elevation: 0.0,

        // Profile picture icon
        leading: IconButton(
          icon: const Image(image: AssetImage('assets/images/profile.png')),
          onPressed: () {
            // Get.offAndToNamed deletes home page off the stack
            Get.toNamed("/profile");
          },
        ),

        // Rank Title
        title: Center(
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            // reference from file
            future: userColRef
                .doc(currentUser.uid)
                .get(), // Use get() to fetch a single snapshot
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final userDocument =
                    snapshot.data!.data() as Map<String, dynamic>;
                final level = userDocument['Level'] ?? 0;
                var rankTitle = rankTitleMap[level] ?? 'Unknown';

                return Text(
                  rankTitle,
                  style: TextStyle(
                    color: iconTextColor,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ).merge(
                      GoogleFonts.quicksand()), // Merge styles with GoogleFonts
                );
              } else {
                return const Text('No data available');
              }
            },
          ),
        ),

        // Nav draw
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: selectedTheme.colorScheme.secondary,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 600,
                    color: selectedTheme.colorScheme.tertiary,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //const SizedBox(height: 15),

                          Container(
                            decoration: BoxDecoration(
                              color:
                                  navDrawTileColor, // Color of the rounded rectangle
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius for desired roundness
                            ),
                            height:
                                6, // Adjust the height of the rectangle as needed
                            width: 40, // Make it span the entire width
                          ),

                          const SizedBox(height: 15),

                          //Intro teaser
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  navDrawTileColor, // Background color for the entire menu
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  tileColor: Colors
                                      .white, // Background color for this ListTile
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
                                    style: TextStyle(
                                        fontSize: 18, color: iconTextColor),
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
                              tileColor: Colors
                                  .white, // Background color for this ListTile
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
                                  style: TextStyle(
                                      fontSize: 18, color: iconTextColor)),
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
                                ).merge(GoogleFonts
                                    .quicksand()), // Merge styles with GoogleFonts
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                Get.toNamed("/faq");
                              },
                              trailing: Text('>',
                                  style: TextStyle(
                                      fontSize: 18, color: iconTextColor)),
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
                                ).merge(GoogleFonts
                                    .quicksand()), // Merge styles with GoogleFonts
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                Get.toNamed("/settings");
                              },
                              trailing: Text('>',
                                  style: TextStyle(
                                      fontSize: 18, color: iconTextColor)),
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
                                ).merge(GoogleFonts
                                    .quicksand()), // Merge styles with GoogleFonts
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const FeedBack()),
                                );
                              },
                              trailing: Text('>',
                                  style: TextStyle(
                                      fontSize: 18, color: iconTextColor)),
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
                                      color:
                                          selectedTheme.colorScheme.secondary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ).merge(GoogleFonts.quicksand()),
                                  ),
                                ],
                              ),
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(scaffoldKey.currentContext!,
                                        rootNavigator: true)
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
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
