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
      'user': firstName,
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
      'curPoints': 0,
      'maxPoints': 4,
      'categoryCompletion': false
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

    //Creating Quiz Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Quiz')
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
        .doc('Quiz')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .set({
      'question': '',
      'options': [],
      'correct_option': '',
    });

    //Creating Read Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Read')
        .collection('Read')
        .doc('read_task_1')
        .set({
      'content': '',
      'title': '',
    });

    //Creating Video Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Watch')
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
