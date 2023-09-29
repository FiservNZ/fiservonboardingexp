import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../firebase references/firebase_refs.dart';
import '../util/achievement_components/achievement_tile.dart';
import '../util/achievement_components/achievement_tracker.dart';
import '../util/constants.dart';

// This class is used to visulaze visualize
class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});
  @override
  Achievementpage createState() => Achievementpage();
}

class Achievementpage extends State<AchievementsPage> {
  AchievementTracker achievementTracker = const AchievementTracker();

  // fetch the achievement list in initialization
  // @override
  // void initState() {
  //   super.initState();
  //   // fetchAndStoreAchievement();
  // }

  // List for the achievements' icon
  final List iconList = [
    'assets/icon/welcome.png',
    'assets/icon/worldwide.png',
    'assets/icon/compliance.png',
    'assets/icon/guidelines.png',
    'assets/icon/technical.png',
    'assets/icon/technical.png',
    'assets/icon/technical.png',
    'assets/icon/technical.png',
    'assets/icon/technical.png',
    'assets/icon/technical.png',
    'assets/icon/technical.png',
    'assets/icon/technical.png',
  ];
  // List of the image showing in the home page
  final List subIconList = [
    'assets/icon/achievement/Unlocked all themes!.png',
    'assets/icon/achievement/First time login!.png',
    'assets/icon/achievement/Submitted feedback!.png',
    'assets/icon/achievement/Changed Icon!.png',
    'assets/icon/achievement/Completing checklist!.png',
    'assets/icon/achievement/Completed orientation!.png',
    'assets/icon/achievement/Completed Compliance!.png',
    'assets/icon/achievement/Completed Health & Safety!.png',
    'assets/icon/achievement/Completed Technical Training!.png',
    'assets/icon/achievement/Completed Customs & Culture!.png',
    'assets/icon/achievement/Completed all the modules!.png',
    'assets/icon/achievement/Unlocked all icons!.png',
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);

    // Update the current user account
    final currentUser = FirebaseAuth.instance.currentUser;
    //Extract the data from achievement collection
    final achievementColRef =
        userColRef.doc(currentUser?.uid).collection("Achievement");

    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      backgroundColor: selectedTheme.colorScheme.background,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: achievementColRef.snapshots(),
        builder: (context, snapshot) {
          // Detect the exception
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Store all the achievement information in list
            final List<Map<String, dynamic>> contentInAchv =
                fetchAndStoreAchievement(snapshot.data!.docs);
            // print(contentInAchv);
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    height: 170.0,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 112, 107, 243),
                    ),
                    child: Stack(
                      children: [
                        // Image config
                        Positioned(
                          top: 10.0,
                          right: 30.0,
                          // bottom: 30,
                          child: Image.asset(
                            'assets/icon/achievement/achievement.png',
                            width: 120,
                            height: 150,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 18.0, top: 20),
                          child: Text(
                            "ACHIEVEMENTS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 55),
                          child: achievementTracker,
                        )
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.3,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        // When the achievement is uncomplete, it will show the lock icon
                        if (contentInAchv[index]['IsComplete'] == false) {
                          contentInAchv[index]['iconData'] =
                              'assets/icon/Lock.png';
                        }
                        return Achievement(
                          title: contentInAchv[index]['name'],
                          iconName: contentInAchv[index]['iconData'] ?? "",
                          isCompleted: contentInAchv[index]['IsComplete'],
                        );
                      },
                      childCount: contentInAchv.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
                // SliverToBoxAdapter(
                //   child: ElevatedButton(
                //     child: const Text("Show"),
                //     onPressed: () =>
                //         updateAchievement(context, "First time login!"),
                //   ),
                // ),
              ],
            );
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }

  //Pop out a information when complete target achievement
  void show(BuildContext context, String targetName) {
    // The widget implement pop out
    AchievementView(
            title: "Yeaaah!",
            subTitle: targetName,
            icon: const Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.white,
            ),
            textStyleSubTitle: const TextStyle(
              color: Colors.white,
            ),
            color: Colors.black,
            isCircle: true,
            typeAnimationContent: AnimationTypeAchievement.fade,
            duration: const Duration(seconds: 2))
        .show(context);
  }

  // When certain achievement has been completed then call this function to update the data.
  Future<void> updateAchievement(
      BuildContext context, String targetName) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      // Extract the data from achievement collection
      final achievementColRef =
          userColRef.doc(currentUser?.uid).collection("Achievement");
      // Search for the name that is equal to the target name
      QuerySnapshot querySnapshot =
          await achievementColRef.where('name', isEqualTo: targetName).get();

      // Check if any documents match the query
      if (querySnapshot.size > 0) {
        // Update isCompleted field
        for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
          DocumentReference docRef = achievementColRef.doc(docSnapshot.id);
          //Only update the achievement when it is uncomplete.
          bool isComplete =
              (docSnapshot.data() as Map<String, dynamic>)['IsComplete'] ??
                  false;
          if (!isComplete) {
            await docRef.update({'IsComplete': true});
            show(context, targetName);
          }
        }
      } else {
        // Handle the case where no matching documents were found
        debugPrint("No documents matching '$targetName' found.");
      }
    } catch (e) {
      // Handle other exceptions
      // ignore: avoid_print
      print("An error occurred: $e");
    }
  }

  List<Map<String, dynamic>> fetchAndStoreAchievement(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    List<Map<String, dynamic>> newAchievementContent = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
      Map<String, dynamic> data = doc.data();
      String name = data['name'] ?? "";
      bool isComplete = data['IsComplete'] ?? false;
      String hour = data['hour'] ?? "";

      // Find the corresponding icon data based on the name
      String subiconData = subIconList.firstWhere(
        (subiconPath) => subiconPath.contains(name),
        orElse: () => '',
      );
      newAchievementContent.add({
        'name': name,
        'IsComplete': isComplete,
        'iconData':
            iconList.isNotEmpty ? iconList[newAchievementContent.length] : '',
        'subiconData': subiconData,
        'hour': hour,
      });
    }
    //Sort the achievement based on the Iscomplete
    //If it has been complete, It will goes to the bottom
    // newAchievementContent.sort((a, b) {
    //   bool isCompleteA = a['IsComplete'] ?? false;
    //   bool isCompleteB = b['IsComplete'] ?? false;
    //   return isCompleteA
    //       ? 1
    //       : isCompleteB
    //           ? -1
    //           : 0;
    // });

    // newAchievementContent
    //     .sort((a, b) => b['IsComplete'].compareTo(a['IsComplete']));

    // print(newAchievementContent);
    return newAchievementContent;
  }
}
