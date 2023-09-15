import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

// create firebase instance
final firestore = FirebaseFirestore.instance;

final fireAuth = FirebaseAuth.instance;
final currentUser = fireAuth.currentUser!;

// reference to the User collection in the Firestore database
final userColRef = firestore.collection('User');

// references user document
DocumentReference userRef({
  // userId is the unique identifier of the "document"
  required String userId,
}) =>
    userColRef.doc(userId);

// references general checklist
// this assumes that the general checklist will be the same for every user. Might need to extend further if this is not the case.
DocumentReference generalChecklistRef({
  // userId is the unique identifier of the "document"
  required String userId,
}) =>
    userRef(userId: userId).collection('General Checklist').doc('list');

DocumentReference taskRef({
  // userId is the unique identifier of the "document"
  required String userId,
  required String taskType,
}) =>
    userRef(userId: userId).collection('Tasks').doc(taskType);

DocumentReference taskTypeRef({
  // userId is the unique identifier of the "document"
  required String userId,
  required String taskType,
  required String taskCol,
  required String taskId,
}) =>
    taskRef(userId: userId, taskType: taskType).collection(taskCol).doc(taskId);

// Used for the current fuctionality of the tasks
final readref = firestore.collection('Read');

DocumentReference readRef({
  required String readId,
}) =>
    readref.doc(readId);
// reference to the Quizzes collection in the Firestore database
final quizref = firestore.collection('Quizzes');

DocumentReference questionRef({
  required String quizId,
  required String questionId,
}) =>
    quizref.doc(quizId).collection("questions").doc(questionId);
