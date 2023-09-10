import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase_references/firebase_refs.dart';
import '../util/achievement_components/achievement_tile.dart';
import '../util/constants.dart';

class AchievementsPage extends StatefulWidget {
  AchievementsPage({super.key});
  @override
  _Achievementpage createState() => _Achievementpage();
}

class _Achievementpage extends State<AchievementsPage> {
  final achievementDoc = userColRef
      .doc(currentUser.uid)
      .collection("Achievement")
      .doc("achievement");
  final achievementCloc =
      userColRef.doc(currentUser.uid).collection("Achievement");
  bool isCircle = false;

  List<Map<String, dynamic>> AchievementContent = [];
  @override
  void initState() {
    super.initState();
    fetchAndStoreAchievement(); // 在初始化时获取数据
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
      backgroundColor: Color.fromARGB(128, 20, 13, 32),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: achievementDoc.snapshots(),
          builder: (context, snapshot) {
            fetchAndStoreAchievement();
            return ListView(
              children: <Widget>[
                Container(
                  height: 170,
                  color: Color.fromARGB(255, 112, 107, 243),
                  child: const Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 0, 100),
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
                      itemCount: AchievementContent.length,
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                      itemBuilder: (context, index) {
                        return Achievement(
                          title: AchievementContent[index]['name'],
                          iconName: IconList[index][0],
                          description: '',
                          isCompleted: AchievementContent[index]['IsComplete'],
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
                  onPressed: () => show(context),
                ),
              ],
            );
          }),
    );
  }

  void show(BuildContext context) {
    AchievementView(
      // title: "Yeaaah!",
      subTitle: "Training completed successfully!",
      isCircle: isCircle,
      typeAnimationContent: AnimationTypeAchievement.fadeSlideToLeft,
      listener: print,
    ).show(context);
  }

  Future<void> fetchAndStoreAchievement() async {
    // 获取 Achievement 集合中的所有文档
    QuerySnapshot querySnapshot = await achievementCloc.get();

    List<Map<String, dynamic>> newAchievementContent = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String name = data['name'] ?? ""; // 获取 name 变量
      bool isComplete = data['IsComplete'] ?? false; // 获取 isComplete 值
      newAchievementContent.add({
        'name': name,
        'IsComplete': isComplete,
      });
    });
    // 更新 AchievementContent 列表
    setState(() {
      AchievementContent = newAchievementContent;
    });
    // print(AchievementContent);
  }
}
