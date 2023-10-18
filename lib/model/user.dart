import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String firstName;
  String lastName;
  String position;
  String iconColor;
  String selectedIcon;
  String theme;
  bool isOSmode;

  String? interestingFacts;
  String? futureSelf;
  String? hobbies;

  int exp;
  int level;
  int maxEXP;

  bool hasIntroduced;
  bool isFirstLog;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.iconColor,
    required this.selectedIcon,
    this.interestingFacts,
    this.futureSelf,
    this.hobbies,
    required this.theme,
    required this.isOSmode,
    required this.exp,
    required this.level,
    required this.maxEXP,
    required this.hasIntroduced,
    required this.isFirstLog,
  });

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        firstName = snapshot['firstName'],
        lastName = snapshot['lastName'],
        position = snapshot['position'],
        iconColor = snapshot['iconColor'],
        selectedIcon = snapshot['selectedIcon'],
        interestingFacts = snapshot['Interesting Facts'],
        futureSelf = snapshot['Future Self'],
        hobbies = snapshot['Hobbies'],
        theme = snapshot['theme'],
        isOSmode = snapshot['isOSmode'] as bool,
        exp = snapshot['question_count'] as int,
        level = snapshot['Level'] as int,
        maxEXP = snapshot['MaxEXP'] as int,
        hasIntroduced = snapshot['introduced'] as bool,
        isFirstLog = snapshot['firstlog'] as bool;
}
