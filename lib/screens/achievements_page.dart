import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/material.dart';
import '../util/category_tile.dart';
import '../util/constants.dart';
import '../widgets/nav_bar.dart';

class AchievementsPage extends StatefulWidget {
  AchievementsPage({super.key});
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<AchievementsPage> {
  bool isCircle = false;
  List moduleCategories = [
    // [categoryName, categoryImage]
    // Orientation (First Week), Compliance, Customs and Culture, Technical training, Health &Safety
    ["Orientation", 'assets/icon/welcome.png'],
    ["Customs & Culture", 'assets/icon/worldwide.png'],
    ["Compliance", 'assets/icon/compliance.png'],
    ["Health & Safety", 'assets/icon/guidelines.png'],
    ["Technical training", 'assets/icon/technical.png'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            color: Color.fromARGB(255, 54, 37, 202),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 100),
                  child: Text(
                    "My honor",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              //width: double.infinity,
              child: GridView.builder(
                itemCount: moduleCategories.length,
                padding: const EdgeInsets.all(12.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                itemBuilder: (context, index) {
                  return CategoryTile(
                    categoryName: moduleCategories[index][0],
                    iconName: moduleCategories[index][1],
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
      ),
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
}
