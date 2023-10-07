import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/themes/dark_theme.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../screens/nav bar pages/achievements_page.dart';

class UserIcon extends StatefulWidget {
  final Icon initialUserIcon;
  final void Function(Icon) onIconChanged;
  final CollectionReference userCollection;
  final String userId;
  final Map<String, dynamic> userData;
  final Color iconColor;
  final int level;

  const UserIcon({
    required this.initialUserIcon,
    required this.onIconChanged,
    required this.userCollection,
    required this.userId,
    required this.userData,
    required this.iconColor,
    required this.level,
  });

  @override
  UserIconState createState() => UserIconState();
}

class UserIconState extends State<UserIcon> {
  late Icon userIcon;
  late Color iconColor;
  Achievementpage achievementpage = Achievementpage();

  // Initial values for userIcon and iconColor are set based on what the user has selected / or default.
  @override
  void initState() {
    super.initState();
    userIcon = widget.initialUserIcon;
    iconColor = widget.iconColor;
  }

  @override
  Widget build(BuildContext context) {
    print('Firebase User Level: ${widget.level}');
    ThemeData selectedTheme = getSelectedTheme(context);
    bool isDarkTheme = selectedTheme == darkTheme;
    // Triggers the popup when the user icon is pressed
    return IconButton(
      icon: widget.initialUserIcon,
      color: widget.iconColor,
      iconSize: 70,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Widget customContent = Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20.0,
                  children: [
                    // When icon is pressed, it updates the user icon, icon colour and is updated to the firebase here.
                    if (widget.level >=
                        1) // If the user is level 1 or higher, the ghost icon is available
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.ghost),
                        iconSize: 55,
                        color: isDarkTheme ? Colors.white : Colors.black87,
                        onPressed: () async {
                          setState(() {
                            userIcon = const Icon(FontAwesomeIcons.ghost);
                          });
                          Navigator.of(context).pop();
                          await widget.userCollection
                              .doc(widget.userId)
                              .update({
                            'selectedIcon': 'ghost',
                            'iconColor': isDarkTheme ? '#FFFFFF' : '#000000',
                          });
                          widget.onIconChanged(userIcon);
                        },
                      ),
                    if (widget.level >=
                        2) // If the user is level 2 or higher, the ghost, seedling icon is available
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.seedling),
                        iconSize: 55,
                        color: Colors.lightGreen.withOpacity(1.0),
                        onPressed: () async {
                          setState(() {
                            userIcon = const Icon(FontAwesomeIcons.seedling);
                          });
                          Navigator.of(context).pop();
                          await widget.userCollection
                              .doc(widget.userId)
                              .update({
                            'selectedIcon': 'seedling',
                            'iconColor': '#8fd94e',
                          });
                          widget.onIconChanged(userIcon);
                        },
                      ),
                    if (widget.level >=
                        3) // If the user is level 3 or higher, the ghost, seedling, poo icon is available
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.poo),
                        iconSize: 55,
                        color: const Color.fromARGB(255, 112, 64, 45),
                        onPressed: () async {
                          setState(() {
                            userIcon = const Icon(FontAwesomeIcons.poo);
                          });
                          Navigator.of(context).pop();
                          await widget.userCollection
                              .doc(widget.userId)
                              .update({
                            'selectedIcon': 'poo',
                            'iconColor': '#402408',
                          });
                          widget.onIconChanged(userIcon);
                        },
                      ),
                    if (widget.level >=
                        4) // If the user is level 4 or higher, the ghost, seedling, poo, fish icon is available
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.fish),
                        iconSize: 55,
                        color: Colors.amberAccent,
                        onPressed: () async {
                          setState(() {
                            userIcon = const Icon(FontAwesomeIcons.fish);
                          });
                          Navigator.of(context).pop();
                          await widget.userCollection
                              .doc(widget.userId)
                              .update({
                            'selectedIcon': 'fish',
                            'iconColor': '#ffbb00',
                          });
                          widget.onIconChanged(userIcon);
                        },
                      ),
                    if (widget.level >=
                        5) // If the user is level 5 or higher, the ghost, seedling, poo, fish, ninja icon is available
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.userNinja),
                        iconSize: 55,
                        color: isDarkTheme ? Colors.white : Colors.black87,
                        onPressed: () async {
                          setState(() {
                            userIcon = const Icon(FontAwesomeIcons.userNinja);
                          });
                          Navigator.of(context).pop();
                          await widget.userCollection
                              .doc(widget.userId)
                              .update({
                            'selectedIcon': 'userNinja',
                            'iconColor': isDarkTheme ? '#FFFFFF' : '#000000',
                          });
                          widget.onIconChanged(userIcon);
                        },
                      ),
                    if (widget.level >=
                        6) // If the user is level 6 or higher, the ghost, seedling, poo, fish, ninja, dog icon is available
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.dog),
                        iconSize: 55,
                        color: Colors.brown,
                        onPressed: () async {
                          setState(() {
                            userIcon = const Icon(FontAwesomeIcons.dog);
                          });
                          Navigator.of(context).pop();
                          await widget.userCollection
                              .doc(widget.userId)
                              .update({
                            'selectedIcon': 'dog',
                            'iconColor': '#a16e3b',
                          });
                          widget.onIconChanged(userIcon);
                        },
                      ),
                    if (widget.level >=
                        7) // If the user is level 7 or higher, the ghost, seedling, poo, fish, ninja, dog, cat icon is available
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.cat),
                        iconSize: 55,
                        color: Colors.orangeAccent,
                        onPressed: () async {
                          setState(() {
                            userIcon = const Icon(FontAwesomeIcons.cat);
                          });
                          Navigator.of(context).pop();
                          await widget.userCollection
                              .doc(widget.userId)
                              .update({
                            'selectedIcon': 'cat',
                            'iconColor': '#ffa41c',
                          });
                          widget.onIconChanged(userIcon);
                        },
                      ),
                    if (widget.level >=
                        8) // If the user is level 8 or higher, the ghost, seedling, poo, fish, ninja, dog, cat, frog icon is available
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.frog),
                        iconSize: 55,
                        color: Colors.green[700],
                        onPressed: () async {
                          setState(() {
                            userIcon = const Icon(FontAwesomeIcons.frog);
                          });
                          Navigator.of(context).pop();
                          await widget.userCollection
                              .doc(widget.userId)
                              .update({
                            'selectedIcon': 'frog',
                            'iconColor': '#11801c',
                          });
                          widget.onIconChanged(userIcon);
                        },
                      ),
                    if (widget.level >=
                        9) // If the user is level 9, the ghost, seedling, poo, fish, ninja, dog, cat, frog, robot icon is available (all icons unlocked)
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.robot),
                        iconSize: 55,
                        color: const Color.fromARGB(255, 78, 79, 82),
                        onPressed: () async {
                          setState(() {
                            userIcon = const Icon(FontAwesomeIcons.robot);
                          });
                          Navigator.of(context).pop();
                          await widget.userCollection
                              .doc(widget.userId)
                              .update({
                            'selectedIcon': 'robot',
                            'iconColor': '#4E4F52',
                          });
                          widget.onIconChanged(userIcon);
                        },
                      ),
                  ],
                ),
              ],
            );

            // Popup window implementation when the user icon is pressed
            return Center(
              child: SizedBox(
                width: 400,
                height: 550,
                child: AlertDialog(
                  backgroundColor: selectedTheme.colorScheme.onBackground,
                  title: Text('My Icons',
                      style:
                          TextStyle(color: selectedTheme.colorScheme.secondary),
                      textAlign: TextAlign.center),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        customContent,
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Text(
                              'Unlock more Icons by gaining EXP!\n      Total of 9 obtainable Icons',
                              style: TextStyle(
                                color: selectedTheme.colorScheme.primary,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    // Close button implementation here
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedTheme.colorScheme.secondary,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(
                            color: selectedTheme.colorScheme.onBackground),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
