
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../repository/branding_repo/b_history_repo/b_history_repo.dart';
import '../model/b_history_model.dart';

class BHistoryController extends GetxController{
  ScrollController scrollController = ScrollController();
  var nameController = TextEditingController();
  var shopNameController = TextEditingController();
  var contact1Controller = TextEditingController();
  var contact2Controller = TextEditingController();
  var addressController = TextEditingController();
  final RxBool isLoading = true.obs;
  var languageList = ['English','Urdu'].obs;
  var itemNameDropDownList = ['T-shirt','Casual','Polo'].obs;
  RxString? selectedValue ='Branding Type'.obs;
  RxString? selectedItemName =''.obs;
  BHistoryRepo bHistoryRepo = BHistoryRepo();
  List<dynamic> bHistoryList = [];
  var bHistoryModel = <BHistoryModel>[].obs;

  
  Future<void> getBHistoryData()async{
    var data = {"SPNAME": "CRMMAP_BrandingSP",
      "ReportQueryParameters":["@nType", "@nsType","@ContactNo"],
      "ReportQueryValue":["0","4","${box.read('userNumber')}"]
    };
    bHistoryRepo.bHistoryApi(data).then((value) {
      bHistoryList = jsonDecode(value);
      for (var element in bHistoryList) {
        bHistoryModel.add(
          BHistoryModel.fromJson(element),
        );
      }
      isLoading.value = false;

      print('length is ${bHistoryModel.length}');
     // debugPrint('------------> branding history: ${bHistoryModel[0].transactionNo}');
    }).onError((error, stackTrace) {
      isLoading.value = false;

      print('error is $error');
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBHistoryData();
  }
}