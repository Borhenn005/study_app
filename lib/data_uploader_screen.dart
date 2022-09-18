// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/controllers/question_paper/data_uploader.dart';
import 'package:study_app/firebase/loading_status.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({super.key});

  DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.loadingStatus.value == LoadingStatus.completed 
            ? Text('uploading completed ') 
            : Text('uploading'),
          )
      ),
    );
  }
}
