import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/api/pdf_api.dart';
import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:fiservonboardingexp/idk/nav_app_overlay.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/mc_testing/watch/video_thumbnail.dart';
import 'package:fiservonboardingexp/widgets/custom_text_box.dart';
import 'package:fiservonboardingexp/widgets/user_icons.dart';
import 'package:fiservonboardingexp/widgets/exp_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/Profile';
  const ProfilePage({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProfilePage(),
    );
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Icon userIcon = const Icon(Icons.person);
  // uses references from file
  final currentUser = fireAuth.currentUser!;

  //final userCollection = FirebaseFirestore.instance.collection('User'); // dont need this anymore
  /*This will show an alert dialogue which will enable us to edit
  information about ourselves which will be saved into
  our database later.*/
  String interestingFacts = 'Tell us something interesting about you...';
  String hobbies = 'Hobbies go here...';
  String futureSelf = 'What/where will you be in 10 years?';
  bool sendButtonPressed = false;

  Future<void> editField(String fieldName) async {
    debugPrint('To implement "$fieldName" edit.');
    String newValue = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          'Edit $fieldName',
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: fieldName == 'Future Self'
                ? 'In 10 years, I wanna be...'
                : fieldName == 'Interesting Facts'
                    ? 'Tell us something interesting...'
                    : 'What are your hobbies?',
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //cancel button to discard changes.
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),

          //Save button to save data into database.
          //For now, this will just change the value on our text field.
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );
    if (newValue.isNotEmpty) {
      //uses references from file
      await userColRef.doc(currentUser.uid).update({fieldName: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    // userIcon variable to change user icon.
    Icon userIcon = Icon(Icons.person);
    ExpBar expBar = ExpBar(barwidth: 200);

    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Profile Page',
          style: TextStyle(
            color: selectedTheme.colorScheme.secondary,
          ),
        ),
        backgroundColor: selectedTheme.colorScheme.tertiary,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("User")
            .doc(currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final level = userData['Level'] ?? 1;

            void asyncMethod(void Function(int) callback) {
              expBar.level.then((int level) {
                callback(level);
              });
            }

            String selectedIcon = userData['selectedIcon'] ?? 'person';
            String iconColor = userData['iconColor'] ?? '#000000';
            VoidCallback? iconOnPressed;

            // Code for user's selected icon display here
            if (userData['selectedIcon'] == 'ghost' && level >= 1) {
              userIcon = Icon(
                FontAwesomeIcons.ghost,
                color: Color(int.parse(iconColor.replaceFirst('#', '0xFF'))),
              );
            } else if (userData['selectedIcon'] == 'seedling' && level >= 2) {
              userIcon = Icon(
                FontAwesomeIcons.seedling,
                color: Color(int.parse(iconColor.replaceFirst('#', '0xFF'))),
              );
            } else if (userData['selectedIcon'] == 'poo' && level >= 3) {
              userIcon = Icon(
                FontAwesomeIcons.poo,
                color: Color(int.parse(iconColor.replaceFirst('#', '0xFF'))),
              );
            } else if (userData['selectedIcon'] == 'fish' && level >= 4) {
              userIcon = Icon(
                FontAwesomeIcons.fish,
                color: Color(int.parse(iconColor.replaceFirst('#', '0xFF'))),
              );
            } else if (userData['selectedIcon'] == 'userNinja' && level >= 5) {
              userIcon = Icon(
                FontAwesomeIcons.userNinja,
                color: Color(int.parse(iconColor.replaceFirst('#', '0xFF'))),
              );
            } else if (userData['selectedIcon'] == 'dog' && level >= 6) {
              userIcon = Icon(
                FontAwesomeIcons.dog,
                color: Color(int.parse(iconColor.replaceFirst('#', '0xFF'))),
              );
            } else if (userData['selectedIcon'] == 'cat' && level >= 7) {
              userIcon = Icon(
                FontAwesomeIcons.cat,
                color: Color(int.parse(iconColor.replaceFirst('#', '0xFF'))),
              );
            } else if (userData['selectedIcon'] == 'frog' && level >= 8) {
              userIcon = Icon(
                FontAwesomeIcons.frog,
                color: Color(int.parse(iconColor.replaceFirst('#', '0xFF'))),
              );
            } else if (userData['selectedIcon'] == 'robot' && level >= 9) {
              userIcon = Icon(
                FontAwesomeIcons.robot,
                color: Color(int.parse(iconColor.replaceFirst('#', '0xFF'))),
              );
            } else {
              userIcon = Icon(
                Icons.person,
                color: selectedTheme.colorScheme.secondary,
              );
              iconOnPressed = null;
            }

            return ListView(
              children: [
                //This is just used for spacing between elements.
                const SizedBox(height: 30),
                //User profile picture, will be pulled from firebase.
                //For now, we will use a placeholder.
                UserIcon(
                  initialUserIcon: userIcon,
                  level: level,
                  onIconChanged: (newIcon) {
                    setState(() {
                      userIcon = newIcon;
                    });
                  },
                  userCollection: userColRef,
                  userId: currentUser.uid,
                  userData: userData,
                  iconColor: Color(
                      int.parse(userData['iconColor'].replaceFirst('#', '0x'))),
                ),

                //User fullname.
                //Using a place holder for now.
                const SizedBox(height: 10),

                Text(
                  '${userData['firstName']} ${userData['lastName']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedTheme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                //ExpBar
                Container(
                  alignment: Alignment.center,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: ExpBar(
                      barwidth: 200,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'About Me:',
                    style: TextStyle(
                      color: selectedTheme.colorScheme.primary,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                //Interesting fact field
                CustomTextBox(
                  text: userData['Interesting Facts'].toString().isEmpty
                      ? interestingFacts
                      : userData['Interesting Facts'],
                  fieldName: 'Interesting Facts',
                  onPressed: () => editField('Interesting Facts'),
                ),

                //Hobbies
                CustomTextBox(
                  text: userData['Hobbies'].toString().isEmpty
                      ? hobbies
                      : userData['Hobbies'],
                  fieldName: 'Hobbies',
                  onPressed: () => editField('Hobbies'),
                ),

                //Future self
                CustomTextBox(
                  text: userData['Future Self'].toString().isEmpty
                      ? futureSelf
                      : userData['Future Self'],
                  fieldName: 'Future Self',
                  onPressed: () => editField('Future Self'),
                ),

                const SizedBox(height: 50),

                /*Submit button will generate a pdf
          Then send that PDF to colleagues*/
                /*I will set send introduction button to work only once.
          After it had been pressed at least 1 time, the button will either disappear
          or will become a logout button instead
          I will still allow users to edit their "about me".*/
                //To be implemented later.
                userData['introduced'] == false
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 120.0,
                          right: 120.0,
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              selectedTheme.colorScheme.secondary,
                            ),
                          ),
                          onPressed: () async {
                            if (userData['Interesting Facts']
                                    .toString()
                                    .isEmpty ||
                                userData['Hobbies'].toString().isEmpty ||
                                userData['Future Self'].toString().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please fill the required information.',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              PdfApi pdfApi = PdfApi(context);
                              final pdfFile = await pdfApi.generate();

                              PdfApi.openFile(pdfFile);
                              debugPrint('Submit button pressed...');
                              //After Send Introduction has been sent once, it will turn into a Logout button.
                              setState(() async {
                                await userColRef
                                    .doc(currentUser.uid)
                                    .update({'introduced': true});
                              });
                            }
                          },
                          child: const Text('Send Introduction'),
                        ),
                      )
                    //The button will disappear once the introduction has been generated.
                    : const SizedBox(height: 5),
                // The code below will turn the functionality of the code above into a logout button
                // if the user has already generated an introduction.
                // : Padding(
                //     padding: const EdgeInsets.only(
                //       left: 120.0,
                //       right: 120.0,
                //     ),
                //     child: ElevatedButton(
                //       style: ButtonStyle(
                //         backgroundColor: MaterialStateProperty.all<Color>(
                //           Colors.grey.shade600,
                //         ),
                //       ),
                //       onPressed: () {
                //         debugPrint('Logout button pressed...');
                //         FirebaseAuth.instance.signOut();
                //         Navigator.pop(context);
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => LoginPage()));
                //         //For testing purposes, we will revert back to Send Introduction button.
                //         //Once fully implemented, it will be a Logout button permanently.
                //         setState(() {
                //           sendButtonPressed = false;
                //         });
                //       },
                //       child: const Text('Logout'),
                //     ),
                //   ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
