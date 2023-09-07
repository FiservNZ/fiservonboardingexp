import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChecklistModel {
  String? id;
  bool hasBooked;
  bool hadCatchUp;
  bool hasBuddy;
  bool hasMachineSetup;
  bool hasMetTeam;
  bool hadCheckpoint;
  bool hasProvidedFeedback;
  bool hasRequestedUVMS;
  bool hasRequestedV1;
  bool hasRequestedGroup;
  bool hadInduction;

  ChecklistModel({
    this.id,
    required this.hasBooked,
    required this.hadCatchUp,
    required this.hasBuddy,
    required this.hasMachineSetup,
    required this.hasMetTeam,
    required this.hadCheckpoint,
    required this.hasProvidedFeedback,
    required this.hasRequestedUVMS,
    required this.hasRequestedV1,
    required this.hasRequestedGroup,
    required this.hadInduction,
  });

  ChecklistModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        hasBooked =
            snapshot['Book onboarding checkpoint with Manager for Day 5']
                as bool,
        hadCatchUp = snapshot['Catch up with buddy'] as bool,
        hasBuddy = snapshot['Identify Buddy'] as bool,
        hasMachineSetup = snapshot['Machine setup'] as bool,
        hasMetTeam = snapshot['Meet your Scrum Team'] as bool,
        hadCheckpoint = snapshot['Onboarding Checkpoint with Manager'] as bool,
        hasProvidedFeedback =
            snapshot['Provide feedback on onboarding process'] as bool,
        hasRequestedUVMS = snapshot['Request access to UVMS dashboard'] as bool,
        hasRequestedV1 = snapshot['Request access to VersionOne (V1)'] as bool,
        hasRequestedGroup =
            snapshot['Request to join Product Development Distribution Group']
                as bool,
        hadInduction = snapshot['Scrum Team Induction'] as bool;
}
