import 'dart:convert';
import 'dart:ui' as UI;

import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../services/app_urls.dart';
import '../model/image_slider_model.dart';

class DashboardController extends GetxController {
  CarouselController carouselController = CarouselController();
  var current = 0;
  var userName = ''.obs;
  var isLoading = false.obs;
  var schemeName1 ='';
  var schemeName2 ='';
  var schemeName3 ='';
  var distributorNum = box.read('userNumber');
  var adminNum = box.read('adminNum');
  List imageModelList = [].obs;
  Dio dio = Dio();
  var response;
  var SLIDER_IMAGE_URL = '${AppUrls.BASEURL}/getdata';
  var USERNAME_URL = '${AppUrls.BASEURL}/getdata';
  UI.TextDirection directionLtr = UI.TextDirection.ltr;

  Future<void> getSliderImages() async {
    try {
      response = await dio.post(
        SLIDER_IMAGE_URL,
        data: {
          "SPNAME": "CRMMAP_WalletSP",
          "ReportQueryParameters":["@nType", "@nsType","@AllowedTo", "@ContactNo"],
          "ReportQueryValue":["0","3",box.read('isDLogin') == true ? "Distributor" : "Retailer", "${box.read('userNumber')}"],
        },
      );
      if(response.statusCode == 200){
        List<dynamic> responseData = jsonDecode(await response.data);

        print('slider data $responseData');
        imageModelList = responseData.map((e) => ImageSliderModel.fromJson(e)).toList();

        
      }
    }on DioError catch (e) {
      
    }
  }

  Future<void> getUserName()async{
    try {
      response = await dio.post(
        USERNAME_URL,
        data: {
          "SPNAME": "CRMMAP_MasterSP",
          "ReportQueryParameters":["@nType","@nsType","@ContactNo"],
          "ReportQueryValue":["0","2","${box.read('userNumber')}"],
        },
      );
      if(response.statusCode == 200){
        List<dynamic> responseData = jsonDecode(await response.data);
        userName.value = responseData[0]['CustomerName'];
      }
    }on DioError catch (e) {
      debugPrint('>>>>> error while getting username $e');
    }
  }
  Future<bool> onBackPressed() async {
    return await Get.defaultDialog(
      title: 'Are you sure?',
      middleText: 'Do you want to exit App',
      textConfirm: 'Yes',
      textCancel: 'No',
      barrierDismissible: true,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Future.delayed(
          const Duration(seconds: 1),
              () {
            SystemNavigator.pop();
          },
        );
        Get.back(result: true);
      },
      onCancel: () => Get.back(result: false),
    );
  }

@override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    logger.i('keke');
  }

}
