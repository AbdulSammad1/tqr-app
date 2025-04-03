import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../main.dart';
import '../../repository/publicity_repo/p_newreq_repo.dart';
import '../../repository/publicity_repo/save_pubreq_repo.dart';
import '../../utils/app_loader.dart';
import '../../utils/constants.dart';
import '../model/p_new_req_model.dart';
import '../model/p_newreq_dropd_model.dart';
import '../model/p_newreq_validmodel.dart';

class NewRequestController extends GetxController {
  var nameController = TextEditingController();
  var shopNameController = TextEditingController();
  var contact1Controller = TextEditingController();
  var contact2Controller = TextEditingController();
  var addressController = TextEditingController();
  var qtyController = TextEditingController();
  var languageList = ['English', 'Urdu'].obs;
  var itemNameDropDownList = ['T-shirt', 'Casual', 'Polo'].obs;
  RxString? selectedValue = 'Select Language'.obs;
  RxString? selectedItemName = 'Item name'.obs;
  RxString? minQty = ''.obs;
  RxBool isSave = false.obs;
  var rate = '0'.obs;
  var totalAmount = '0'.obs;
  PubNewRequestRepo pubNewRequestRepo = PubNewRequestRepo();
  SavePubRequestRepo savePubRequestRepo = SavePubRequestRepo();
  List<dynamic> pNewReqList = [];
  List<dynamic> pNewReqDropDList = [];
  List<dynamic> pNewReqVList = [];
  var pNewReqModel = <PNewRequestModel>[].obs;
  var pNewReqDropDModel = <PNewReqDropDModel>[].obs;
  var pNewReqVModel = <PNReqVlidationModel>[].obs;

  Future<void> getPNewReqDropDData(BuildContext context) async {
    appLoader(context, Constants.PRIMARY_COLOR);
    var data = {
      "SPNAME": "CRMMAP_PublicitySP",
      "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
      "ReportQueryValue": ["0", "2", "${box.read('userNumber')}"]
    };
    pubNewRequestRepo
        .pNewRequestDropDownApi(data)
        .then((value) => {
              pNewReqDropDList = jsonDecode(value),
              for (var element in pNewReqDropDList)
                {
                  pNewReqDropDModel.add(
                    PNewReqDropDModel.fromJson(element),
                  ),
                },
              Get.back(),
              // print('-----> data: ${pNewReqDropDModel[0].itemName}')
            })
        .onError((error, stackTrace) => {
              Get.back(),
              Utils.appSnackBar(
                title: 'Error',
                subtitle: 'Something went wrong',
              ),

            });
  }

  Future<void> getPNewReqData() async {
    var data = {
      "SPNAME": "CRMMAP_PublicitySP",
      "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
      "ReportQueryValue": ["0", "1", "${box.read('userNumber')}"]
    };
    pubNewRequestRepo
        .pNewRequestApi(data)
        .then((value) => {
              pNewReqList = jsonDecode(value),
              for (var element in pNewReqList)
                {
                  pNewReqModel.add(
                    PNewRequestModel.fromJson(element),
                  ),
                },
              nameController.text = '${pNewReqModel[0].name}',
              shopNameController.text = '${pNewReqModel[0].shopName}',
              contact1Controller.text = '${pNewReqModel[0].contactNo}',
              contact2Controller.text = '${pNewReqModel[0].contactNo2}',
              addressController.text = '${pNewReqModel[0].address}',

            });
  }

  void totalAmountCalculation({var itemCtrl, var itemRate}) {
    totalAmount.value = (int.parse(itemRate) * int.parse(itemCtrl)).toString();
  }

  Future<void> savePublicityData(var itemName,itemQty,itemRate,totalAmount, userName, shopName, contact1,
      contact2, address, language,BuildContext context) async {
    isSave.value = true;
    var validationData = {
      "SPNAME": "CRMMAP_PublicitySP",
      "ReportQueryParameters": [
        "@nType",
        "@nsType",
        "@ContactNo",
        "@ItemName",
        "@Quantity",
        "@Rate",
        "@Amount",
        "@Name",
        "@ShopName",
        "@ContactNo1",
        "@ContactNo2",
        "@Address",
        "@Language"
      ],
      "ReportQueryValue": [
        "0",
        "5",
        "${box.read('userNumber')}",
        "$itemName",
        "$itemQty",
        "$itemRate",
        "$totalAmount",
        "$userName",
        "$shopName",
        "$contact1",
        "$contact2",
        "$address",
        "$language"
      ]
    };

    pubNewRequestRepo.pNewRequestValidationApi(validationData).then((value) => {
      pNewReqVList = jsonDecode(value),
      for(var element in pNewReqVList){
        pNewReqVModel.add(
          PNReqVlidationModel.fromJson(element),
        ),
      },
      if(pNewReqVModel[0].status == 1){
        isSave.value = false,
       Navigator.pop(context),
        Utils.appSnackBar(
          title: 'Success',
          subtitle: '${pNewReqVModel[0].message}',
          bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
        ),
      }else{
        isSave.value = false,
        Utils.appSnackBar(
          title: 'Error',
          subtitle: '${pNewReqVModel[0].message}',
        ),
      },
      // debugPrint('------------> Validation status: ${pNewReqVModel[0].status}'),
    }).onError((error, stackTrace) => {
      isSave.value = false,
      Utils.appSnackBar(
        title: 'Error',
        subtitle: 'Something went wrong',
      ),
    });
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    shopNameController.dispose();
    contact1Controller.dispose();
    contact2Controller.dispose();
    addressController.dispose();
    qtyController.dispose();
  }
}
