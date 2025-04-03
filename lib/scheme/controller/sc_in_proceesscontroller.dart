import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../repository/in_progress_repo/in_progress_repo.dart';
import '../model/in_progress_model.dart';

class ScInProcessController extends GetxController{
 final InProgressRepository _inProgressRepository = InProgressRepository();
 var inProgressModel = <InProgressModel>[].obs;
 List<dynamic> inProgressList = [];
 final RxBool isLoading = true.obs;
 ScrollController scrollController = ScrollController();

 void getInProgressData(){
  var data = {"SPNAME": "CRMMAP_SchemeSignSP",
   "ReportQueryParameters":["@nType", "@nsType","@ContactNo"],
   "ReportQueryValue":["0","3","${box.read('userNumber')}"]
  };
    _inProgressRepository.inProgressApi(data).then((value) {
    inProgressList = jsonDecode(value);
    for (var element in inProgressList) {
     inProgressModel.add(InProgressModel.fromJson(element));
    }
    isLoading.value = false;
    // debugPrint('------------> Date: ${inProgressModel[0].date}');
   }).onError((error, stackTrace) {
      isLoading.value = false;
   });
 }

}