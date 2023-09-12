import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/screens/task%20pages/task_page.dart';
import 'package:fiservonboardingexp/util/task_components/task.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyTaskTileState createState() => _MyTaskTileState();
}

class _MyTaskTileState extends State<TaskTile> {
  var collection = FirebaseFirestore.instance.collection("Task");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Center(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: collection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var documentData = data[index].data();
                    var taskName = documentData['name'];
                    var popUpContent = documentData['popUpContent'];
                    var taskType = documentData['type'];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.brown[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: Text(taskName),
                            subtitle: Text(taskType),
                            leading: Lottie.asset(
                                'assets/animations/reading_book.json'),
                            onTap: () => _showPopup(context, taskName,
                                popUpContent, data[index].id, taskType)),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

void _showPopup(BuildContext context, String taskName, String popUpContent,
    String documentId, String taskType) {
  var collection = FirebaseFirestore.instance.collection("Task");
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Theme(
        data: Theme.of(context).copyWith(
          dialogBackgroundColor: Colors.white,
        ),
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          title: Text(taskName),
          content: Text(popUpContent),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // On press of the button, the pop up window should close
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                // On press of the button, should be taken to weekonepage.dart
                TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    icon: Image.asset(
                      'assets/icon/start-button.png',
                      width: 60,
                      height: 60,
                    ),
                    label: const SizedBox.shrink(),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      DocumentSnapshot<Map<String, dynamic>> snapshot =
                          await collection.doc(documentId).get();
                      if (snapshot.exists) {
                        Task task = Task(
                          id: documentId,
                          name: taskName,
                          type: taskType,
                          //type: snapshot.data()!['type'],
                          popUpContent: popUpContent,
                        );
                        // ignore: use_build_context_synchronously
                        if (taskName == "Video Task") {
                          // ignore: use_build_context_synchronously
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskPage(
                                      task: task,
                                    )),
                          );
                        } else if (taskName == "Quiz Task") {
                          // ignore: use_build_context_synchronously
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskPage(
                                task: task,
                              ),
                            ),
                          );
                        }
                      }
                    }),
              ],
            ),
          ],
        ),
      );
    },
  );
}
