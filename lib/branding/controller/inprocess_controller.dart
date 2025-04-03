import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../repository/branding_repo/b_inprocess_repo/b_inprocess_repo.dart';
import '../model/b_inprocess_model.dart';

class InProcessController extends GetxController {
  ScrollController scrollController = ScrollController();
  final brandingTypeList = ['Sign board', 'Bill board', 'Simple flex'].obs;
 final RxBool isLoading = true.obs;
  RxString? selectedValue ='Branding Type'.obs;
  var nameController = TextEditingController();
  var shopNameController = TextEditingController();
  var contact1Controller = TextEditingController();
  var contact2Controller = TextEditingController();
  var addressController = TextEditingController();
  var languageList = ['English','Urdu'].obs;
  RxString? langValue ='Select Language'.obs;
  BInProcessRepo bInProcessRepo = BInProcessRepo();
  List<dynamic> bInProcessList = [];
  var bInProcessModel = <BInProcessModel>[].obs;

  Future<void> getBInProcessData()async{
    var data = {
      "SPNAME": "CRMMAP_BrandingSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
      "ReportQueryValue": ["0", "3","${box.read('userNumber')}"]
    };
    bInProcessRepo.bInProcessApi(data).then((value) {
      bInProcessList = jsonDecode(value);
      for (var element in bInProcessList) {
        bInProcessModel.add(
          BInProcessModel.fromJson(element),
        );
      }
      isLoading.value = false;
    //  debugPrint('------------> branding type: $value');
    //   debugPrint('------------> branding type: ${bInProcessModel[0].transactionNo}');
    }).onError((error, stackTrace) {
      isLoading.value = false;
      // debugPrint('------------> error: $error');
    });
  }

}