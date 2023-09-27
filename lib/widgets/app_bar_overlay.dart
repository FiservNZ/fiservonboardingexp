import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/widgets/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../firebase references/firebase_refs.dart';

class AppBarOverlay extends StatelessWidget implements PreferredSizeWidget {
  const AppBarOverlay({super.key, User? currentUser});

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);

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
                    color: selectedTheme.colorScheme.secondary,
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
                  return NavDraw(); // Use the new component here
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
