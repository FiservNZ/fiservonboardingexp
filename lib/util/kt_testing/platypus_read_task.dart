import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

class DeviceSetUp extends StatefulWidget {
  const DeviceSetUp({super.key});

  @override
  DeviceSetUpState createState() => DeviceSetUpState();
}

class DeviceSetUpState extends State<DeviceSetUp> {
  DeviceSetUpState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Read")
              .doc('read1')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final data = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  const SizedBox(height: 30),

                  //Title
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '${data['title']}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: fiservColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  //Content
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Text(
                      '${data['content']}',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Color(0xFFFF6600),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: fiservColor,
                          fixedSize: Size(120, 35)),
                      child: const Text('Task Finished'),
                    ),
                  ),

                  const SizedBox(height: 30)
                ],
              );
            }
          }),
    );
  }
}
