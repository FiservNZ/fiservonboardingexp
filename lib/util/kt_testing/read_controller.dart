import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/kt_testing/firebase_reference.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_model.dart';
import 'package:get/get.dart';

class ReadController extends GetxController {
  late ReadModel document;
  final allReadTasks =
      <ReadModel>[]; // Initializes a collection of read tasks as an array.
  RxInt selectedIndex = RxInt(0); // Initialize with a default index of 0.

  @override
  void onReady() {
    getAllReadTasks();
    super.onReady();
  }

  // Defines the setSelectedIndex method
  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> getAllReadTasks() async {
    try {
      // Fetch the read documents from the read collection as a map.
      QuerySnapshot<Map<String, dynamic>> data = await readref.get();

      print("Number of documents fetched: ${data.docs.length}");

      final readList = data.docs.map((document) {
        // Convert each document to a ReadModel.
        return ReadModel(
          id: document.id,
          title: document['title'],
          content: document['content'],
        );
      }).toList();

      // Assign the list of ReadModel objects to allReadTasks.
      allReadTasks.assignAll(readList);

      // After data is loaded, the selected index an be set.
      setSelectedIndex(0);
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
