import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/services/app_urls.dart';

import '../../main.dart';
import '../../repository/signed_repo/signed_repo.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../model/history_model.dart';
import '../model/save_signed_model.dart';
import '../model/signed_edit_model.dart';
import '../model/signed_model.dart';
import '../model/signed_update_model.dart';

import 'package:http/http.dart' as http;

class SignedSchController extends GetxController{
  ScrollController scrollController = ScrollController();
  SignedRepo signedRepo = SignedRepo();
  var signedModelList = <SignedSchemeModel>[].obs;
  var signedHistoryModelList = <SignedHistoryModel>[].obs;
  var signedEditModelList = <SignedEditModel>[].obs;
  var signedUpdateModelList = <SignedUpdateModel>[].obs;
  var saveSignedModelList = <SaveSignedModel>[].obs;
  List<dynamic> signedSchList = [];
   List<dynamic> signedSchHistoryList = [];
  List<dynamic> signedSchEditList = [];
  List<dynamic> signedSchUpdateList = [];
  List<dynamic> saveSignedList = [];
  var customerNameController = TextEditingController().obs;
  var schemeNameController = TextEditingController().obs;
  var quantityController = TextEditingController().obs;
  var amountController = TextEditingController().obs;
  RxString? selectedValue = 'Update Status'.obs;
  RxString? statusValue = 'a'.obs;
  RxBool isSave = false.obs;
  RxInt status1 = 0.obs;
  var message = ''.obs;
  final RxBool isLoading = true.obs;


   Future<void> refreshData() async {
    signedModelList.clear(); // Clear the existing data list
    await getSignedSchemeData(); // Fetch fresh data
  }

  Future<void> getSignedSchemeData()async{
    var data = {"SPNAME": "CRMMAP_SchemeSignSP",
      "ReportQueryParameters":["@nType", "@nsType","@ContactNo"],
      "ReportQueryValue":["0","9","${box.read('userNumber')}"]
    };


    signedRepo.signedApi(data).then((value) {
    
      isLoading.value = false;
      signedSchList = jsonDecode(value);
      for(var element in signedSchList){
        signedModelList.add(
          SignedSchemeModel.fromJson(element),
        );
      }
        
    }).onError((error, stackTrace) {
        isLoading.value = false;  
    });
  }

  Future<void> getSignedHistoryData()async{

    var data = {"SPNAME": "CRMMAP_SchemeSignSP",
      "ReportQueryParameters":["@nType", "@nsType","@ContactNo"],
      "ReportQueryValue":["0","14","${box.read('userNumber')}"]
    };



    signedRepo.signedhistoryApi(data).then((value) {
      signedSchHistoryList = jsonDecode(value);
      for(var element in signedSchHistoryList){
        signedHistoryModelList.add(
          SignedHistoryModel.fromJson(element),
        );
      }
      isLoading.value = false;

    }).onError((error, stackTrace) {
      isLoading.value = false;
    });
  }

  Future<void> getSignedEditData(var tracNum)async{
    var data = {"SPNAME": "CRMMAP_SchemeSignSP",
      "ReportQueryParameters":["@nType", "@nsType","@SchemeTransNo"],
      "ReportQueryValue":["0","10","$tracNum"]
    };
    signedRepo.signedEditApi(data).then((value) {
      signedSchEditList = jsonDecode(value);
      for(var element in signedSchEditList){
        signedEditModelList.add(
          SignedEditModel.fromJson(element),
        );
      }
    }).onError((error, stackTrace) {

    });
  }

  Future<void> getSignedUpdateData(var tracNum)async{
    var data = {"SPNAME": "CRMMAP_SchemeSignSP",
      "ReportQueryParameters":["@nType", "@nsType", "@SchemeTransNo"],
      "ReportQueryValue":["0","7", '$tracNum']
    };
    signedRepo.signedStatusUpdateApi(data).then((value) {
      signedSchUpdateList = jsonDecode(value);
      for(var element in signedSchUpdateList){
        signedUpdateModelList.add(
          SignedUpdateModel.fromJson(element),
        );
      }
    });
  }

  Future<void> saveSignedData(var status,transId)async{
    isSave.value = true;
    var data = {"SPNAME": "CRMMAP_SchemeSignSP",
      "ReportQueryParameters":["@nType","@nsType","@SchemeStatus","@SchemeTransNo"],
      "ReportQueryValue":["1","2","$status","$transId"]
    };
    signedRepo.saveSignedDataApi(data).then((value) {
      isSave.value = false;
      saveSignedList = jsonDecode(value);

      for(var element in saveSignedList){
        saveSignedModelList.add(
          SaveSignedModel.fromJson(element),
        );
      }
      status1.value = saveSignedModelList[0].status!;
      message.value = saveSignedModelList[0].message!;
      if(status1.value==1){
        Future.delayed(
            const Duration(seconds: 1)).then((
            value) => Get.back(closeOverlays: true),);
        Utils.appSnackBar(
          title: 'Success',
          subtitle: message.value,
          bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
        );
      }else{
        Utils.appSnackBar(
          title: 'Failed',
          subtitle: message.value,
          bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
        );
      }
    }).onError((error, stackTrace) {
      isSave.value = false;
    });
    
  }

  


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSignedSchemeData();
    getSignedHistoryData();
  }
}