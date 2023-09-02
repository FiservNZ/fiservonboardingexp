import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import 'package:fiservonboardingexp/widgets/progress_bar.dart';

class PlatypusRead extends StatelessWidget {
  final ProgressBar _progressBar = const ProgressBar();
  const PlatypusRead({super.key});

  // @override
  //PlatypusReadState createState() => PlatypusReadState();
//}

//class PlatypusReadState extends State<PlatypusRead> {
  //PlatypusReadState();

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
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      '${data['title']}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: fiservColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 42,
                      ),
                    ),
                  ),

                  //Image (from local assets folder not firebase)
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child:
                        Image(image: AssetImage('assets/images/platypus.webp')),
                  ),

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

                  //Close button
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

                  //Task finished button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: ElevatedButton(
                      onPressed: () {
                        int points = 1;
                        _progressBar.addPoints(points);
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
