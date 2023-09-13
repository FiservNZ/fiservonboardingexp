import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      //Change later to match theme selected.
      backgroundColor: darkBackgroundColor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Missions',
              style: GoogleFonts.quicksand(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _customMissionTile('Orientation'),
                  _customMissionTile('Customs & Culture'),
                  _customMissionTile('Health & Safety'),
                  _customMissionTile('Compliance'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customMissionTile(String title) {
    return GestureDetector(
      onTap: () {
        String route = title.replaceAll(" ", "");
        debugPrint('Route: $route');

        Get.toNamed("/$route");
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: darkTileColor,
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
                  height: 30,
                ),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            //Try to implement later if time allows.
            // Positioned(
            //   right: 5,
            //   top: 1,
            //   bottom: 1,
            //   child: CircularProgressIndicator(
            //     //Will need to implement tracking on firebase and grabbing the value from there.
            //     value: 0.3,
            //     backgroundColor: Colors.grey[600],
            //     valueColor: const AlwaysStoppedAnimation<Color>(fiservColor),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
