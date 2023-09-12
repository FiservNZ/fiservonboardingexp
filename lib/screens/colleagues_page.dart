import 'package:flutter/material.dart';
import '../util/constants.dart';
import '../model/colleagues.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ColleaguesPage extends StatefulWidget {
  const ColleaguesPage({Key? key}) : super(key: key);

  @override
  _ColleaguesPageState createState() => _ColleaguesPageState();
}

// List of colleagues and details written in here
class _ColleaguesPageState extends State<ColleaguesPage> {
  List<Colleagues> colleagues = [
    Colleagues(
      name: 'IT Support',
      position: 'Help Desk',
      phoneNumber: '1111111111',
      email: 'FiservHelp@gmail.com',
      hobbies: 'Helping',
    ),
    Colleagues(
      name: 'Emily Smith',
      position: 'Manager',
      phoneNumber: '1234567890',
      email: 'emilysmith@gmail.com',
      hobbies: 'Fishing',
    ),
    Colleagues(
      name: 'Jane Kim',
      position: 'Developer',
      phoneNumber: '9876543210',
      email: 'janekim@gmail.com',
      hobbies: 'Cooking',
    ),
    Colleagues(
      name: 'Bob Lee',
      position: 'Developer',
      phoneNumber: '1232323232',
      email: 'boblee@gmail.com',
      hobbies: 'Gaming',
    ),
  ];

  // UI implementation of the colleagues page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: const CustomNavBar(),
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                // Colleagues Title here
                child: Text(
                  'COLLEAGUES',
                  style: GoogleFonts.quicksand(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: fiservColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Shows the Colleagues names, role, and icon here
            Expanded(
              child: ListView.builder(
                itemCount: colleagues.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    // Colleagues icon set to the person icon by default
                    leading: const CircleAvatar(
                      radius: 22,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFFFF6600),
                    ),
                    // UI for Colleague Name here
                    title: Text(
                      colleagues[index].name,
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    // UI for Colleague Position here
                    subtitle: Text(
                      colleagues[index].position,
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // When the user presses a colleague, it shows the popup with the colleague details
                    onTap: () {
                      _showColleagueDetails(colleagues[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Implementation of the popup of colleagues details.
  void _showColleagueDetails(Colleagues colleague) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 27, 27, 27),
          // Colleague details title
          title: Text(
            'COLLEAGUE DETAILS',
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: fiservColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          // SingleChildScrollView is used to prevent pixel overflow
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Colleague Name UI here
                Text(
                  'Name: ${colleague.name}',
                  style: TextStyle(
                    color: Colors.white, // Colleague Name Font Colour
                  ),
                ),
                // Colleague Position UI here
                Text(
                  'Position: ${colleague.position}',
                  style: TextStyle(
                    color: Colors.white, // Colleague Position Font Colour
                  ),
                ),
                Row(
                  // Colleague Phone Number UI here
                  children: [
                    const Text(
                      'Phone Number: ',
                      style: TextStyle(
                          color: Colors
                              .white), // Colleague Phone Number Font Colour
                    ),
                    // Implementation when the user presses the phone number, the phone dial app opens with the phone number in it
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: colleague.phoneNumber,
                            style: TextStyle(color: fiservColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchPhoneNumber(colleague
                                    .phoneNumber); // Launch dial app here with the colleague phone number
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Colleague Email UI
                Row(
                  children: [
                    const Text('Email: ',
                        style: TextStyle(
                            color:
                                Colors.white)), // Colleague Email Font Colour
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: colleague.email,
                            style: const TextStyle(color: fiservColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchEmail(colleague
                                    .email); // Launch default email (gmail) app with the colleagues email preentered in the app
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Colleague Hobbies UI
                Text('Hobbies: ${colleague.hobbies}',
                    style: TextStyle(
                        color: Colors.white)), // Colleague Hobbies Font Colour
              ],
            ),
          ),
          // Close Button UI, returns to previous page/screen
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6600),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

// Implementation to launch dial application on android device
  void _launchPhoneNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    final String phoneUrl = phoneUri.toString();

    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }

// Implementation to launch default gmail/mail application on device
  void _launchEmail(String email) async {
    String subject = Uri.encodeComponent("Query");
    print(subject);
    Uri mail = Uri.parse("mailto:$email?subject=$subject");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }
}
