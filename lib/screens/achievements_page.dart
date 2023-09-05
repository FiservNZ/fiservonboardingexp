import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import '../util/constants.dart';
import '../widgets/nav_bar.dart';

class AchievementsPage extends StatefulWidget {
  AchievementsPage({super.key});
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<AchievementsPage> {
  bool isCircle = false; // 初始状态：未选中
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: CustomNavBar(),
      body: Column(
        children: <Widget>[
          Checkbox(
            value: isCircle,
            onChanged: (change) => setState(() => isCircle = change!),
          ),
          const Text("isCircle"),
          ElevatedButton(
            child: const Text("Show"),
            onPressed: () => show(context),
          )
        ],
      ),
    );
  }

  void show(BuildContext context) {
    AchievementView(
      title: "Yeaaah!",
      subTitle: "Training completed successfully! ",
      isCircle: isCircle,
      listener: print,
    ).show(context);
  }
}
