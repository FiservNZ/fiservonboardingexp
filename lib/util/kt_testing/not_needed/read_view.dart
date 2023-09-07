/*
import 'package:fiservonboardingexp/util/kt_testing/Loading_stat.dart';
import 'package:fiservonboardingexp/util/kt_testing/uploader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadView extends StatelessWidget {
  ReadView({super.key});
  Uploader controller = Get.put(Uploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(
            controller.loadingStatus.value == LoadingStat.completed
                ? "Uploading Completed!"
                : "uploading")),
      ),
    );
  }
}
*/