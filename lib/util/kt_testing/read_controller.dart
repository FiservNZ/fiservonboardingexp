import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/kt_testing/firebase_reference.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_model.dart';
import 'package:get/get.dart';

class ReadController extends GetxController {
  //final loadingStatus = LoadingStat.loading.obs;
  late ReadModel read;
  final allReadTasks = <ReadModel>[];

/*
  @override
  void onReady() {
    final readTask = Get.arguments as ReadModel;
    // test to see if it can pull the read document id from the collection
    print(readTask.id);
    loadData(readTask);
    super.onReady();
  }

  Future<void> loadData(ReadModel readTask) async {
    readModel = readTask;
    //loadingStatus.value = LoadingStat.loading;

    try {
      // Query the 'Read' collection for documents
      final QuerySnapshot<Map<String, dynamic>> readQuery =
          await readref.doc(readTask.id).collection("Read").get();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    */

  @override
  void onReady() {
    getAllReadTasks();
    super.onReady();
  }

  Future<void> getAllReadTasks() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await readref.get();
      final readList =
          data.docs.map((read) => ReadModel.fromSnapshot(read)).toList();
      allReadTasks.assignAll(readList);
    } catch (e) {
      print(e);
    }
  }
}
