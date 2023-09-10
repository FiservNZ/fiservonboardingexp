import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase_references/firebase_refs.dart';
import '../util/achievement_components/achievement_tile.dart';
import '../util/constants.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});
  @override
  Achievementpage createState() => Achievementpage();
}

class Achievementpage extends State<AchievementsPage> {
  final achievementDoc = userColRef
      .doc(currentUser.uid)
      .collection("Achievement")
      .doc("achievement");
  final achievementColRef =
      userColRef.doc(currentUser.uid).collection("Achievement");
  bool isCircle = false;

  List<Map<String, dynamic>> _achievementContent = [];
  @override
  void initState() {
    super.initState();
    fetchAndStoreAchievement(); // fetch the achievement list in initialization
  }

  // List AchievementContent = [
  //   // [categoryName, categoryImage]
  //   // Orientation (First Week), Compliance, Customs and Culture, Technical training, Health &Safety
  //   ["Kevin", 'assets/icon/welcome.png'],
  //   ["Customs & Culture", 'assets/icon/worldwide.png'],
  //   ["Compliance", 'assets/icon/compliance.png'],
  //   ["Health & Safety", 'assets/icon/guidelines.png'],
  //   ["Technical training", 'assets/icon/technical.png'],
  // ];
  // ignore: non_constant_identifier_names
  List IconList = [
    ['assets/icon/welcome.png'],
    ['assets/icon/worldwide.png'],
    ['assets/icon/compliance.png'],
    ['assets/icon/guidelines.png'],
    ['assets/icon/technical.png'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      backgroundColor: const Color.fromARGB(128, 20, 13, 32),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: achievementDoc.snapshots(),
          builder: (context, snapshot) {
            fetchAndStoreAchievement();
            return ListView(
              children: <Widget>[
                Container(
                  height: 170,
                  color: const Color.fromARGB(255, 112, 107, 243),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 0, 100),
                        child: Text(
                          "My Honor",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    //width: double.infinity,
                    child: GridView.builder(
                      itemCount: _achievementContent.length,
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                      itemBuilder: (context, index) {
                        return Achievement(
                          title: _achievementContent[index]['name'],
                          iconName: IconList[index][0],
                          description: '',
                          isCompleted: _achievementContent[index]['IsComplete'],
                        );
                      },
                    ),
                  ),
                ),
                Checkbox(
                  value: isCircle,
                  onChanged: (change) => setState(() => isCircle = change!),
                ),
                const Text("isCircle"),
                ElevatedButton(
                  child: const Text("Show"),
                  onPressed: () => show(context, "Level 9"),
                ),
              ],
            );
          }),
    );
  }

  void show(BuildContext context, String name) {
    AchievementView(
      // title: "Yeaaah!",
      subTitle: "Training completed successfully!",
      isCircle: isCircle,
      typeAnimationContent: AnimationTypeAchievement.fadeSlideToLeft,
      listener: print,
    ).show(context);
    updateAchievement(name);
  }

  Future<void> updateAchievement(String targetName) async {
    // 查询文档中 name 字段等于 "level 9" 的文档
    QuerySnapshot querySnapshot =
        await achievementColRef.where('name', isEqualTo: targetName).get();

    // 遍历匹配的文档并更新 isCompleted 字段
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      // 获取文档的引用
      DocumentReference docRef = achievementColRef.doc(docSnapshot.id);

      // 更新 isCompleted 字段为 true
      await docRef.update({'IsComplete': true});
    }
  }

  Future<void> fetchAndStoreAchievement() async {
    // Get doc in achievement collection
    QuerySnapshot querySnapshot = await achievementColRef.get();

    List<Map<String, dynamic>> newAchievementContent = [];

    querySnapshot.docs.forEach((doc) {
      //Get value from firestone
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String name = data['name'] ?? "";
      bool isComplete = data['IsComplete'] ?? false;
      newAchievementContent.add({
        'name': name,
        'IsComplete': isComplete,
      });
    });
    // Update AchievementContent
    setState(() {
      _achievementContent = newAchievementContent;
    });
    // print(AchievementContent);
  }
}
