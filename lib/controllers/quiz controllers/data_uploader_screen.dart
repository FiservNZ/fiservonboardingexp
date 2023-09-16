import 'package:fiservonboardingexp/controllers/quiz%20controllers/data_uploader.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({super.key});
  final DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(
            controller.loadingStatus.value == LoadingStatus.completed
                ? "Uploading Completed!"
                : "uploading")),
      ),
    );
  }
}
