import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/widgets/custom_text_box.dart';
import 'package:flutter/material.dart';

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
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('User');
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
      await userCollection.doc(currentUser.uid).update({fieldName: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Page',
          style: TextStyle(
            color: Color(0xFFFF6600),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("User")
            .doc(currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                //This is just used for spacing between elements.
                const SizedBox(height: 30),
                //User profile picture, will be pulled from firebase.
                //For now, we will use a placeholder.
                IconButton(
                  icon: const Icon(Icons.person),
                  color: const Color(0xFFFF6600),
                  iconSize: 50,
                  onPressed: () {
                    debugPrint(
                        'Edit profile avatar/picture to be implemented...');
                  },
                ),
                //User fullname.
                //Using a place holder for now.
                const SizedBox(height: 10),

                Text(
                  '${userData['firstName']} ${userData['lastName']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'About Me:',
                    style: TextStyle(
                      color: Colors.grey.shade700,
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
                sendButtonPressed == false
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 120.0,
                          right: 120.0,
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFFF6600),
                            ),
                          ),
                          onPressed: () {
                            debugPrint('Submit button pressed...');
                            //After Send Introduction has been sent once, it will turn into a Logout button.
                            setState(() {
                              sendButtonPressed = true;
                            });
                          },
                          child: const Text('Send Introduction'),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                          left: 120.0,
                          right: 120.0,
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade600,
                            ),
                          ),
                          onPressed: () {
                            debugPrint('Logout button pressed...');
                            //For testing purposes, we will revert back to Send Introduction button.
                            //Once fully implemented, it will be a Logout button permanently.
                            setState(() {
                              sendButtonPressed = false;
                            });
                          },
                          child: const Text('Logout'),
                        ),
                      ),
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
