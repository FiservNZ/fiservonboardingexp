import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../firebase_references/firebase_refs.dart';
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
  //Extract the data from achievement collection
  final achievementColRef =
      userColRef.doc(currentUser.uid).collection("Achievement");

  List<Map<String, dynamic>> contentInAchv = [];

  // fetch the achievement list in initialization
  // @override
  // void initState() {
  //   super.initState();
  //   fetchAndStoreAchievement();
  // }

  // List for storing the icon
  // ignore: non_constant_identifier_names
  final List IconList = [
    'assets/icon/welcome.png',
    'assets/icon/worldwide.png',
    'assets/icon/compliance.png',
    'assets/icon/guidelines.png',
    'assets/icon/technical.png',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      backgroundColor: selectedTheme.colorScheme.background,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: achievementColRef.snapshots(),
        builder: (context, snapshot) {
          // Store all the achievement information in list
          fetchAndStoreAchievement(contentInAchv);

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
                      iconName: contentInAchv[index]['iconData'],
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
    updateAchievement(targetName);
  }

  Future<void> updateAchievement(String targetName) async {
    // Seach the name where is equal to the traget name
    QuerySnapshot querySnapshot =
        await achievementColRef.where('name', isEqualTo: targetName).get();

    // Update isCompleted field
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      DocumentReference docRef = achievementColRef.doc(docSnapshot.id);

      await docRef.update({'IsComplete': true});
    }
  }

  Future<void> fetchAndStoreAchievement(
      List<Map<String, dynamic>> newAchievementContent) async {
    // Get doc in achievement collection
    QuerySnapshot querySnapshot = await achievementColRef.get();

    // List<Map<String, dynamic>> newAchievementContent = [];

    querySnapshot.docs.forEach((doc) {
      //Get value from firestone
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String name = data['name'] ?? "";
      bool isComplete = data['IsComplete'] ?? false;

      // Find the corresponding icon data based on the name
      // List iconData = IconList.firstWhere(
      //   (iconData) => iconData[0] == 'assets/icon/$name.png',
      //   orElse: () => [],
      // );

      newAchievementContent.add({
        'name': name,
        'IsComplete': isComplete,
        'iconData':
            IconList.isNotEmpty ? IconList[newAchievementContent.length] : '',
      });
    });
    // print(newAchievementContent);
    // return newAchievementContent;
    // Update AchievementContent
    // setState(() {
    //   _achievementContent = newAchievementContent;
    // });
  }
}
