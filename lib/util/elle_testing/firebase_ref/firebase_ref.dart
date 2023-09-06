import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

// create firebase instance
final firestore = FirebaseFirestore.instance;

// reference to the Quizzes collection in the Firestore database
final quizref = firestore.collection('Quizzes');

DocumentReference questionRef({
  required String quizId,
  required String questionId,
}) =>
    quizref.doc(quizId).collection("questions").doc(questionId);
