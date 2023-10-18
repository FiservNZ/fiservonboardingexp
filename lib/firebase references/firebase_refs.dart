import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

// create firebase instance
final firestore = FirebaseFirestore.instance;

final fireAuth = FirebaseAuth.instance;
// file is not able to correctly pull the user state with this
final currentUser = fireAuth.currentUser!;
// final currentUpdatedUser = FirebaseAuth.instance.currentUser;
// reference to the User collection in the Firestore database
final userColRef = firestore.collection('User');

String uid = fireAuth.currentUser!.uid;

final userDocRef = userColRef.doc(uid);

final tasksCollectionRef = userDocRef.collection('Tasks');
final complianceRef = tasksCollectionRef.doc('Compliance');
final complianceQuiz = complianceRef.collection('Quiz');
DocumentReference complianceQRef({
  required String quizId,
  required String questionId,
}) =>
    complianceQuiz.doc(quizId).collection("questions").doc(questionId);

final orientationRef = tasksCollectionRef.doc('Orientation');
final orientationQuiz = orientationRef.collection('Quiz');
DocumentReference orientationQRef({
  required String quizId,
  required String questionId,
}) =>
    orientationQuiz.doc(quizId).collection("questions").doc(questionId);

final healthSafetyRef = tasksCollectionRef.doc('Health & Safety');
final healthSafetyQuiz = healthSafetyRef.collection('Quiz');
DocumentReference healthSafetyQRef({
  required String quizId,
  required String questionId,
}) =>
    healthSafetyQuiz.doc(quizId).collection("questions").doc(questionId);

final customsCultureRef = tasksCollectionRef.doc('Customs & Culture');
final customsCultureQuiz = customsCultureRef.collection('Quiz');
DocumentReference customsCultureQRef({
  required String quizId,
  required String questionId,
}) =>
    customsCultureQuiz.doc(quizId).collection("questions").doc(questionId);

final achievementsCollectionRef = userDocRef.collection('Achievements');
final checklistCollectionRef = userDocRef.collection('General Checklist');

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
