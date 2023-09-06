import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/material.dart';
import '../util/constants.dart';
import '../widgets/nav_bar.dart';

class AchievementsPage extends StatefulWidget {
  AchievementsPage({super.key});
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<AchievementsPage> {
  bool isCircle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: CustomNavBar(),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            color: Color.fromARGB(255, 54, 37, 202), // 可以根据需要更改颜色
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 100),
                  child: Text(
                    "My honor",
                    style: TextStyle(
                      color: Colors.white, // 可以根据需要更改文本颜色
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
          // 这里添加您现有的内容
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
