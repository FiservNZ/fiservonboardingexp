import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_provider.dart';
import '../util/achievement_components/incompleted_achievement.dart';
import '../widgets/app_bar_overlay.dart';
import '../widgets/exp_bar.dart';
import '../widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    final currentUser = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: selectedTheme.colorScheme.background,
        appBar: AppBarOverlay(
          currentUser: currentUser,
        ),
        bottomNavigationBar: const CustomNavBar(),
        body: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 15),

              // Getting user name
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("User")
                    .doc(currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    final firstName = userData['firstName'] ?? 'First Name';
                    final lastName = userData['lastName'] ?? 'Last Name';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome message + name
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: TextStyle(
                                  color: selectedTheme.colorScheme.secondary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$firstName $lastName',
                                style: TextStyle(
                                  color: selectedTheme.colorScheme.secondary,
                                  fontSize: 21,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Display exp bar
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                          child: const ExpBar(barwidth: 300),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),

              const SizedBox(height: 30),

              // Achievement title text
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                        'Achievements',
                        style: TextStyle(
                          color: selectedTheme.colorScheme.secondary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Achievement tiles
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: IncompletedAchievement(),
                ),
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}




// PREVIOUS HOMEPAGE IMPLEMENTATION HERE LEFT IT JUST INCASE SOME1 NEEDS IT NO PROBLEM

// class HomePage extends StatelessWidget {
//   final ExpBar _expBar = const ExpBar(barwidth: 300);
//   final ProgressBar _progressBar = const ProgressBar();

//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     ThemeData selectedTheme = themeProvider.currentTheme;
//     ReadController readController = Get.find();

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: selectedTheme.colorScheme.background,
//         appBar: const AppBarOverlay(),
//         bottomNavigationBar: const CustomNavBar(),

//         //Floating action button
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.green,
//           foregroundColor: Colors.white,
//           onPressed: () {
//             int expToAdd = 200;
//             _expBar.addExperience(expToAdd);
//           },
//           child: const Icon(Icons.navigation),
//         ),

//         //Home Page
//         body: SafeArea(
//           child: ListView(
//             children: [
//               const SizedBox(height: 15),

//               //expBar
//               Padding(
//                 padding: const EdgeInsets.only(left: 12),
//                 child:
//                     Container(alignment: Alignment.centerLeft, child: _expBar),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),

//               const SizedBox(height: 30),

//               //Progress bar
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Container(
//                     alignment: Alignment.centerLeft, child: _progressBar),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               // IncompletedAchievement
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Container(
//                   alignment: Alignment.centerLeft,
//                   child: IncompletedAchievement(),
//                 ),
//               ),
//               const SizedBox(height: 200),

//               //Read task for platypus article
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 120),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (readController.allReadTasks.isNotEmpty) {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               ReadPage(model: readController.allReadTasks[0]),
//                         ),
//                       );
//                     } else {
//                       // Where allReadTasks is empty or data is not available.
//                       print("Sorry, no data available");
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: selectedTheme.colorScheme.onBackground,
//                     fixedSize: Size(120, 35),
//                   ),
//                   child: Text(
//                     'Read Task',
//                     style: TextStyle(
//                       color: selectedTheme.colorScheme.secondary,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ).merge(GoogleFonts
//                         .quicksand()), // Merge styles with GoogleFonts
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
