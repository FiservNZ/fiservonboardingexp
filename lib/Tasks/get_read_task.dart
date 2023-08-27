import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List studentsList = [];
final CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("Tasks");

Future getData() async {
  try {
    //to get data from a single/particular document alone.
    var temp = await collectionRef.doc("read_task_1").get();

    // to get data from all documents sequentially
    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        studentsList.add(result.data());
      }
    });

    return studentsList;
  } catch (e) {
    debugPrint("Error - $e");
    return e;
  }
}
