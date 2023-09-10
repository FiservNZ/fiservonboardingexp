import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_controller.dart';

class ReadModel {
  String id;
  String title;
  String content;

  ReadModel({required this.id, required this.title, required this.content});
}
