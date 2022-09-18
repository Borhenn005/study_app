import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_app/firebase/loading_status.dart';
import 'package:study_app/models/question_paper_model.dart';

import '../../firebase/firebase_ref.dart';

class DataUploader extends GetxController{

  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  // loadingStatus is obs
  final loadingStatus = LoadingStatus.loading.obs ; //0

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading ; 
    final fireStore = FirebaseFirestore.instance; 
    final manifestContent = await DefaultAssetBundle.of(Get.context!).loadString('AssetManifest.json');
    final Map<String,dynamic> manfiestMap =  json.decode(manifestContent);

    // load json data and print assets
    final paperInAssets = manfiestMap.keys.where((path) => path.startsWith('assets/DB/papers') && path.contains('.json')).toList();

    List<QuestionPaperModel> questionPapers = [];
    for(var paper in paperInAssets){
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers.add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
    }
    var batch = fireStore.batch();

    for(var paper in questionPapers){
      batch.set(questionPaperRF.doc(paper.id), {
        'title' : paper.title,
        'image_url' : paper.imageUrl,
        'description' : paper.description,
        'time_seconds' : paper.timeSeconds,
        'questions_count' : paper.questions == null ? 0 : paper.questions!.length  
      });

      for (var questions in paper.questions!){
        final questionPath = questionRF(paperID: paper.id, questionID: questions.id);
        batch.set(questionPath, {
          'questions' : questions.question,
          'correct_answer' : questions.correctAnswer,
        });

        for (var answer in questions.answers){
          batch.set(questionPath.collection('answers').doc(answer.identifier), {
            'identifier' : answer.identifier,
            'answer' : answer.answer,
          });
        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed ; //1 

  }
}