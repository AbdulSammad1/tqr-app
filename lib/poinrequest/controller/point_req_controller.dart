import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/main.dart';
import 'package:tqrfamily_bysaz_flutter/services/app_urls.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../dashboard/model/points_model.dart';
import '../../repository/point_req_repo/point_req_repo.dart';
import '../../utils/app_snackbar.dart';

class PointRequestController extends GetxController {
  var pointController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  String defaultRemarks = 'Please collect payment and add to my wallet';

  final pointRequestRepo = PointRequestRepo();
  var pointsModel = <PointsModel>[].obs;
  List<dynamic> pointsList = [];
  Dio dio = Dio();
  var WALLET_URL = '${AppUrls.BASEURL}/getdata';
  var points;
  dynamic pts;
  var val;
  var verifyOtp = false.obs;

  var response;
  final NumberFormat formatter = NumberFormat('#,##0');

  void submitPointRequest(String points, String? remarks) async {
    var data = {
      "SPNAME": "CRMMAP_WalletSP",
      "ReportQueryParameters": [
        "@nType",
        "@nsType",
        "@ContactNo",
        "@QuantityInPoints",
        "@Remarks"
      ],
      "ReportQueryValue": [
        "1",
        "0",
        "${box.read('userNumber')}",
        points,
        remarks
      ]
    };

    pointRequestRepo.pointRequestApi(data).then((value) {
      print(value);

      var apiResponse = jsonDecode(value);
      var apiValue = apiResponse[0];

      if (apiValue["Status"] == 1) {
        Get.back();
        
        Future.delayed(const Duration(seconds: 1), () {
         
          Utils.appSnackBar(
              title: 'Successful',
              subtitle: apiValue['MessageCaption'],
              bgColor: Colors.blue);
         
        });
         Get.back();
        dashBRefreshPointRequest();
        pointController.clear();
      } else {
        Get.back();
        appSnackBar(subtitle: apiValue['MessageCaption'], title: 'Error');
      }
      // debugPrint('>>>>>>point request: $value  : $points   : $remarks');
    }).onError((error, stackTrace) {
      appSnackBar(subtitle: 'Something went wrong', title: 'Error');
    });
  }

  Future<void> dashBRefreshPointRequest() async {
    //923009255600
    try {
      response = await dio.post(
        WALLET_URL,
        data: {
          "SPNAME": "CRMMAP_WalletSP",
          "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
          "ReportQueryValue": ["0", "0", "${box.read('userNumber')}"],
        },
      );
      if (response.statusCode == 200) {
        Get.back();
        List<dynamic> responseData = jsonDecode(await response.data);
        points = responseData[0]['WalletBalance'];
        pts = responseData[0]['WalletBalance'];
        val = points;
        update();
        box.write('walletPoints', val);
        update();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        Get.back();
        box.read('isDistributorLogin') == true
            ? debugPrint('---> Error while getting points')
            : Utils.appSnackBar(
                subtitle: 'Error while getting points', title: 'Error');
      } else {
        Get.back();
      }
    }
  }

  Future<void> validatePtsMethod() async {
    //923009255600
    try {
      response = await dio.post(
        WALLET_URL,
        data: {
          "SPNAME": "CRMMAP_WalletSP",
          "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
          "ReportQueryValue": ["0", "0", "${box.read('userNumber')}"],
        },
      );
      if (response.statusCode == 200) {
        pointsList = jsonDecode(await response.data);
        pointsModel.addAll(pointsList.map((e) => PointsModel.fromJson(e)));
        pts = pointsModel[0].walletBalance?.replaceAll(',', '');
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        box.read('isDistributorLogin') == true
            ? debugPrint('---> Error while getting points')
            : Utils.appSnackBar(
                subtitle: 'Error while getting points', title: 'Error');
      } else {}
    }
  }

  Future<void> refreshPointsMethod() async {
    //923009255600
    try {
      response = await dio.post(
        WALLET_URL,
        data: {
          "SPNAME": "CRMMAP_WalletSP",
          "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
          "ReportQueryValue": ["0", "0", "${box.read('userNumber')}"],
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(await response.data);
        val = responseData[0]['WalletBalance'];
        update();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        box.read('isDistributorLogin') == true
            ? debugPrint('---> Error while getting points')
            : Utils.appSnackBar(
                subtitle: 'Error while getting points', title: 'Error');
      } else {}
    }
  }
}
