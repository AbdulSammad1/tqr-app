
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../repository/publicity_repo/p_history_repo.dart';
import '../model/p_history_model.dart';

class PHistoryController extends GetxController{
  ScrollController scrollController = ScrollController();
  var nameController = TextEditingController();
  var shopNameController = TextEditingController();
  var contact1Controller = TextEditingController();
  var contact2Controller = TextEditingController();
  var addressController = TextEditingController();
  var languageList = ['English','Urdu'].obs;
  RxString? langValue ='Select Language'.obs;
  final RxBool isLoading = true.obs;
  var itemNameDropDownList = ['T-shirt','Casual','Polo'].obs;
  RxString? selectedValue =''.obs;
  RxString? selectedItemName =''.obs;
  PHistoryRepo pHistoryRepo = PHistoryRepo();
  List<dynamic> pHistoryList = [];
  var pHistoryModel = <PHistoryModel>[].obs;


  
  Future<void> getPHistoryData()async{
    var data = {"SPNAME": "CRMMAP_PublicitySP",
      "ReportQueryParameters":["@nType", "@nsType","@ContactNo"],
      "ReportQueryValue":["0","4","${box.read('userNumber')}"]
    };
    pHistoryRepo.pHistoryApi(data).then((value) => {
      pHistoryList = jsonDecode(value),
      for(var element in pHistoryList){
        pHistoryModel.add(
          PHistoryModel.fromJson(element),
        )
      },
      isLoading.value = false,
    }).onError((error, stackTrace) => {
      isLoading.value = false,

    });
  }
}