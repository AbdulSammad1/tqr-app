import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../repository/scheme_history_repo/scheme_history_repo.dart';
import '../model/scheme_history_model.dart';

class SchemeHistoryController extends GetxController{
  final SchemeHistoryRepository _schemeHistoryRepository = SchemeHistoryRepository();
  var historyModel = <SchemeHistoryModel>[].obs;
  List<dynamic> inProgressList = [];
  final RxBool isLoading = true.obs;
  ScrollController scrollController = ScrollController();

  void getHistoryData(){
    var data = {"SPNAME": "CRMMAP_SchemeSignSP",
      "ReportQueryParameters":["@nType", "@nsType","@ContactNo"],
      "ReportQueryValue":["0","4","${box.read('userNumber')}"]
    };
    _schemeHistoryRepository.schemeHistoryApi(data).then((value) {
      inProgressList = jsonDecode(value);
      for (var element in inProgressList) {
        historyModel.add(SchemeHistoryModel.fromJson(element));
      }
      isLoading.value = false;

    }).onError((error, stackTrace) {
      isLoading.value = false;
    });
  }
}