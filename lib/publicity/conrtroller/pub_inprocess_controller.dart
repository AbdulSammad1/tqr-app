
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../repository/publicity_repo/p_inprocess_repo.dart';
import '../model/p_inprocess_model.dart';

class PubInProcessController extends GetxController {
  ScrollController scrollController = ScrollController();
  final brandingTypeList = ['Sign board', 'Bill board', 'Simple flex'].obs;
  RxString? selectedValue ='Branding Type'.obs;
  final RxBool isLoading = true.obs;
  var nameController = TextEditingController();
  var shopNameController = TextEditingController();
  var contact1Controller = TextEditingController();
  var contact2Controller = TextEditingController();
  var addressController = TextEditingController();
  var languageList = ['English','Urdu'].obs;
  RxString? langValue ='Select Language'.obs;
  RxString? selectedItemName =''.obs;
  PInProcessRepo pInProcessRepo = PInProcessRepo();
  List<dynamic> pInProcessList = [];
  var pInProcessModel = <PInProcessModel>[].obs;

  Future<void> getPInProcessData()async{
    var data = {"SPNAME": "CRMMAP_PublicitySP",
      "ReportQueryParameters":["@nType", "@nsType","@ContactNo"],
      "ReportQueryValue":["0","3","${box.read('userNumber')}"]
    };
    pInProcessRepo.pInProcessApi(data).then((value) => {
      pInProcessList = jsonDecode(value),
      for(var element in pInProcessList){
        pInProcessModel.add(
          PInProcessModel.fromJson(element),
        )
      },
      isLoading.value = false,
    }).onError((error, stackTrace) => {
      isLoading.value = false,
    });
  }
}