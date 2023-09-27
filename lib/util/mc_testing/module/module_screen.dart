import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/mc_testing/watch/watch_tasks_container.dart';
import 'package:fiservonboardingexp/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

late String currentCategory;

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({super.key});
  static const routeName = "/moduleScreen";

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);

    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      backgroundColor: selectedTheme.colorScheme.background,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Missions',
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    color: selectedTheme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _customMissionTile('Orientation', selectedTheme),
                  _customMissionTile('Customs & Culture', selectedTheme),
                  _customMissionTile('Health & Safety', selectedTheme),
                  _customMissionTile('Compliance', selectedTheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customMissionTile(String title, ThemeData selectedTheme) {
    return GestureDetector(
      onTap: () {
        // String route = title.replaceAll(" ", "");
        currentCategory = title;
        debugPrint('Route: $currentCategory');
        // Get.toNamed(WatchHomeScreen.routeName, arguments: currentCategory);
        Get.toNamed("/home", arguments: currentCategory);

        //Modify this to take into consideration other task types
        Get.to(WatchTasksContainer(watchCategory: currentCategory));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selectedTheme.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Image.asset(
                  title == 'Orientation'
                      ? 'assets/icon/welcome.png'
                      : title == 'Customs & Culture'
                          ? 'assets/icon/worldwide.png'
                          : title == 'Health & Safety'
                              ? 'assets/icon/health.png'
                              : title == 'Compliance'
                                  ? 'assets/icon/compliance.png'
                                  : 'assets/icon/technical.png',
                  width: 30,
                  height: 60,
                ),
                //const SizedBox(width: 5),
                Text(
                  title,
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      color: selectedTheme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Spacer(),
                ProgressBar(taskCategory: title),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
