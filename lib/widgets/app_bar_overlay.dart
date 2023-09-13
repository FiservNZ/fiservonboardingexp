import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:fiservonboardingexp/screens/feedback_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppBarOverlay extends StatelessWidget implements PreferredSizeWidget {
  const AppBarOverlay({super.key});
  @override
  Widget build(BuildContext context) {
    //final currentUser = FirebaseAuth.instance.currentUser!; No need
    //final userCollection = FirebaseFirestore.instance.collection('User'); No need for this

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

    return AppBar(
        backgroundColor: Colors.black,
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
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            // reference from file
            stream: userColRef.doc(currentUser.uid).snapshots(),
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
                  style: TextStyle(color: Color(0xFFFF6600)),
                );
              } else {
                return const Text('No data available');
              }
            },
          ),
        ),

        // Nav draw
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xFFFF6600),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 350,
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          //Intro teaser
                          ListTile(
                            leading: const Icon(
                              Icons.list,
                              color: Color(0xFFFF6600),
                            ),
                            title: const Text(
                              'Intro Teaser',
                              style: TextStyle(color: Color(0xFFFF6600)),
                            ),
                            onTap: () {
                              Get.toNamed("/teaser");
                            },
                          ),

                          // Help pop up
                          ListTile(
                            leading: const Icon(
                              Icons.question_mark,
                              color: Color(0xFFFF6600),
                            ),
                            title: const Text(
                              'Help',
                              style: TextStyle(color: Color(0xFFFF6600)),
                            ),
                            onTap: () {
                              Get.toNamed("/help");
                            },
                          ),

                          // FAQ
                          ListTile(
                            leading: const Icon(
                              Icons.question_answer,
                              color: Color(0xFFFF6600),
                            ),
                            title: const Text(
                              'FAQ',
                              style: TextStyle(color: Color(0xFFFF6600)),
                            ),
                            onTap: () {
                              Get.toNamed("/faq");
                            },
                          ),

                          // Settings
                          ListTile(
                            leading: const Icon(
                              Icons.settings,
                              color: Color(0xFFFF6600),
                            ),
                            title: const Text(
                              'Settings',
                              style: TextStyle(color: Color(0xFFFF6600)),
                            ),
                            onTap: () {
                              Get.toNamed("/settings");
                            },
                          ),

                          ListTile(
                            leading: const Icon(
                              Icons.feedback_outlined,
                              color: Color(0xFFFF6600),
                            ),
                            title: const Text(
                              'Feedback',
                              style: TextStyle(color: Color(0xFFFF6600)),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => FeedBack()),
                              );
                            },
                          ),

                          const SizedBox(
                            width: double.infinity,
                            height: 65,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
