import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/branding/model/b_type_model.dart';

import '../../main.dart';
import '../../repository/branding_repo/branding_type_repo/branding_type.dart';

class TypeController extends GetxController {
  var dateTime = ''.obs;
  BrandingTypeRepo typeRepo = BrandingTypeRepo();
  var bTypeModel = <BTypeModel>[].obs;
  List<dynamic> bTypeList = [];
  ScrollController scrollController = ScrollController();

  void currentDateOnly() {
    var date = DateTime.now();
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    dateTime.value = formattedDate;
  }

  Future<void> getTypeData() async {
    var data = {
      "SPNAME": "CRMMAP_BrandingSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
      "ReportQueryValue": ["0", "0", "${box.read('userNumber')}"]
    };
    typeRepo.brandingTypeApi(data).then((value) {
      bTypeList = jsonDecode(value);
      for (var element in bTypeList) {
        bTypeModel.add(
          BTypeModel.fromJson(element),
        );
      }
      // debugPrint('------------> Date: ${bTypeModel[0].minimumAdvance}');
    }).onError((error, stackTrace) {
      // debugPrint('------------> error while getting type data: $error');
      
    });
  }



  @override
  void onInit() {
    super.onInit();
    currentDateOnly();
    getTypeData();
  }
}
