import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

final firestore = FirebaseFirestore.instance;

final quizref = firestore.collection('Quizzes');

DocumentReference questionRef({
  required String quizId,
  required String questionId,
}) =>
    quizref.doc(quizId).collection("questions").doc(questionId);
