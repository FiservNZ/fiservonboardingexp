import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

final firestore = FirebaseFirestore.instance;
final readref = firestore.collection('Read');

DocumentReference readRef({
  required String readId,
}) =>
    readref.doc(readId);
