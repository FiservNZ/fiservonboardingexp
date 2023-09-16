import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../firebase references/firebase_refs.dart';
import '../util/achievement_components/achievement_tile.dart';
import '../util/achievement_components/achievement_tracker.dart';
import '../util/constants.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});
  @override
  Achievementpage createState() => Achievementpage();
}

class Achievementpage extends State<AchievementsPage> {
  AchievementTracker achievementTracker = const AchievementTracker();

  List<Map<String, dynamic>> contentInAchv = [];

  // fetch the achievement list in initialization
  @override
  void initState() {
    super.initState();
    // fetchAndStoreAchievement();
  }

  // List for storing the icon
  // ignore: non_constant_identifier_names
  final List IconList = [
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

  final List SubiconList = [
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Store all the achievement information in list
            fetchAndStoreAchievement(contentInAchv);
          }
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  height: 170.0,
                  decoration: BoxDecoration(
                    //
                    color: selectedTheme.colorScheme.onBackground,
                  ),
                  child: Stack(
                    children: [
                      // Image config
                      Positioned(
                        top: 35.0,
                        right: 30.0,
                        child: Image.asset(
                          'assets/icon/welcome.png',
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0, top: 50),
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
                        padding: const EdgeInsets.only(left: 16.0, top: 85),
                        child: achievementTracker,
                      )
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.5,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Achievement(
                      size: 3,
                      title: contentInAchv[index]['name'],
                      iconName: contentInAchv[index]['iconData'] ?? "",
                      award: '',
                      isCompleted: contentInAchv[index]['IsComplete'],
                    );
                  },
                  childCount: contentInAchv.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
              SliverToBoxAdapter(
                child: ElevatedButton(
                  child: const Text("Show"),
                  onPressed: () => show(context, "Level 9"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // When certain achievement has been completed then call this function to update the data.
  //Pop out a information when complete target achievement
  void show(BuildContext context, String targetName) {
    // The widget implement pop out
    AchievementView(
            // title: "Yeaaah!",
            subTitle: "$targetName completed successfully!",
            icon: const Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.white,
            ),
            textStyleSubTitle: const TextStyle(
              color: fiservColor,
            ),
            color: Colors.black,
            isCircle: true,
            typeAnimationContent: AnimationTypeAchievement.fade,
            duration: const Duration(seconds: 2))
        .show(context);
  }

  Future<void> updateAchievement(
      BuildContext context, String targetName) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      // Extract the data from achievement collection
      final achievementColRef =
          userColRef.doc(currentUser?.uid).collection("Achievement");
      print(currentUser?.uid);
      // Search for the name that is equal to the target name
      QuerySnapshot querySnapshot =
          await achievementColRef.where('name', isEqualTo: targetName).get();

      // Check if any documents match the query
      if (querySnapshot.size > 0) {
        // Update isCompleted field
        for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
          DocumentReference docRef = achievementColRef.doc(docSnapshot.id);
          await docRef.update({'IsComplete': true});
        }
        // ignore: use_build_context_synchronously
        show(context, targetName);
      } else {
        // Handle the case where no matching documents were found
        // For example, you can show an error message or perform other actions.
        print("No documents matching '$targetName' found.");
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

      // Find the corresponding icon data based on the name
      String subiconData = SubiconList.firstWhere(
        (subiconPath) => subiconPath.contains(name),
        orElse: () => '',
      );
      newAchievementContent.add({
        'name': name,
        'IsComplete': isComplete,
        'iconData':
            IconList.isNotEmpty ? IconList[newAchievementContent.length] : '',
        // 'subiconData': SubiconList.isNotEmpty
        //     ? SubiconList[newAchievementContent.length]
        //     : '',
        'subiconData': subiconData,
      });
    }
    print(newAchievementContent);
    return newAchievementContent;
  }
}
