import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:flutter/material.dart';

Future<String?> signUpWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user!.uid;
  } catch (e) {
    debugPrint('Exception Found: $e');
    return null;
  }
}

Future<void> saveUserDetails(
    String? uid, String firstName, String lastName, String position) async {
  try {
    await userColRef.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'position': position,
      'Future Self': '',
      'Hobbies': '',
      'Interesting Facts': '',
      'EXP': 0,
      'Level': 1,
      'MaxEXP': 150,
      'firstlog': true,
      'iconColor': '#ff6600',
      'introduced': false,
      'selectedIcon': 'person',
    });

    //Creating a General Checklist collection specific to the user to have it more specific to the user
    //Also making it easier for the user to add tasks specific to them and tracking completion easier.
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('General Checklist')
        .doc('list')
        .set({
      'Book onboarding checkpoint with Manager for Day 5': false,
      'Catch up with buddy': false,
      'Identify Buddy': false,
      'Machine setup': false,
      'Meet your Scrum Team': false,
      'Onboarding Checkpoint with Manager': false,
      'Provide feedback on onboarding process': false,
      'Request access to UVMS dashboard': false,
      'Request access to VersionOne (V1)': false,
      'Request to join Product Development Distribution Group': false,
      'Scrum Team Induction': false,
    });

    initialiseOrientationTasks(uid);
    initialiseCCTasks(uid);
    initialiseComplianceTasks(uid);
    initialiseHSTasks(uid);
  } catch (e) {
    debugPrint('Exception Found: $e');
  }
}

//Used to initialise Orientation-Related Tasks
Future<void> initialiseOrientationTasks(String? uid) async {
  try {
    //Creating Orientation-related Quiz Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .set({
      'description': '',
      'title': '',
      'question_count': 1,
      'duration': 10,
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .set({
      'question': '',
      'options': [],
      'correct_option': '',
    });

    //Creating Orientation-related Read Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Read')
        .doc('read_task_1')
        .set({
      'content': '',
      'title': '',
    });

    //Creating Orientation-related Video Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Watch')
        .doc('watch_task_1')
        .set({
      'title': '',
      'videoUrl': '',
    });
  } catch (e) {
    debugPrint('Exception Found: $e');
  }
}

//Used to initialise Customs&Culture-Related Tasks
Future<void> initialiseCCTasks(String? uid) async {
  try {
    //Creating Customs&Culture-related Quiz Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Customs & Culture')
        .collection('Quiz')
        .doc('quiz_task_1')
        .set({
      'description': '',
      'title': '',
      'question_count': 1,
      'duration': 10,
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Customs & Culture')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .set({
      'question': '',
      'options': [],
      'correct_option': '',
    });

    //Creating Customs&Culture-related Read Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Customs & Culture')
        .collection('Read')
        .doc('read_task_1')
        .set({
      'content': '',
      'title': '',
    });

    //Creating Customs&Culture-related Video Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Customs & Culture')
        .collection('Watch')
        .doc('watch_task_1')
        .set({
      'title': '',
      'videoUrl': '',
    });
  } catch (e) {
    debugPrint('Exception Found: $e');
  }
}

//Used to initialise Compliance-Related Tasks
Future<void> initialiseComplianceTasks(String? uid) async {
  try {
    //Creating Compliance-related Quiz Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Compliance')
        .collection('Quiz')
        .doc('quiz_task_1')
        .set({
      'description': '',
      'title': '',
      'question_count': 1,
      'duration': 10,
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Compliance')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .set({
      'question': '',
      'options': [],
      'correct_option': '',
    });

    //Creating Compliance-related Read Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Compliance')
        .collection('Read')
        .doc('read_task_1')
        .set({
      'content': '',
      'title': '',
    });

    //Creating Compliance-related Video Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Compliance')
        .collection('Watch')
        .doc('watch_task_1')
        .set({
      'title': '',
      'videoUrl': '',
    });
  } catch (e) {
    debugPrint('Exception Found: $e');
  }
}

//Used to initialise Health&Safety-Related Tasks
Future<void> initialiseHSTasks(String? uid) async {
  try {
    //Creating Health&Safety-related Quiz Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Health & Safety')
        .collection('Quiz')
        .doc('quiz_task_1')
        .set({
      'description': '',
      'title': '',
      'question_count': 1,
      'duration': 10,
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Health & Safety')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .set({
      'question': '',
      'options': [],
      'correct_option': '',
    });

    //Creating Health&Safety-related Read Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Health & Safety')
        .collection('Read')
        .doc('read_task_1')
        .set({
      'content': '',
      'title': '',
    });

    //Creating Health&Safety-related Video Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Health & Safety')
        .collection('Watch')
        .doc('watch_task_1')
        .set({
      'title': '',
      'videoUrl': '',
    });
  } catch (e) {
    debugPrint('Exception Found: $e');
  }
}
