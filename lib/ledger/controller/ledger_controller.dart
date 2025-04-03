import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/services/app_urls.dart';

import '../../main.dart';
import '../../repository/ledger_repo/t_a_balance_repo.dart';
import '../model/all_timeblnc_model.dart';
import '../model/points_in_tmmodel.dart';
import '../model/points_model.dart';
import '../model/points_out_model.dart';
import '../model/pointsout_tm_model.dart';
import '../model/summary_model.dart';
import '../model/summary_tm_model.dart';
import '../model/this_monthblnc_model.dart';

class LedgerController extends GetxController {
  var scrollController = ScrollController();
  var scrollController2 = ScrollController();
  var scrollController3 = ScrollController();
  var scrollController4 = ScrollController();
  var scrollController5 = ScrollController();
  var scrollController6 = ScrollController();
  var allTimeOBlnc = '0'.obs;
  var allTimeCBlnc = '0'.obs;
  var thisMonthOBlnc = '0'.obs;
  var thisMonthCBlnc = '0'.obs;
  var tabIndex = 0.obs;
  var dio = Dio();
  var response;
  final RxBool isLoading = true.obs;
  TABalanceRepo tABalanceRepo = TABalanceRepo();
  List<dynamic> responseData = [];
  List<dynamic> responseData1 = [];
  List<dynamic> responseData2 = [];
  List<dynamic> tmDateResponse = [];
  List<dynamic> tmDesResponse = [];
  List<dynamic> tmAmountResponse = [];
  List<dynamic> allTimeBlncList = [];
  List<dynamic> thisMonthBlncList = [];
  var pointsInModel = <PointsInModel>[].obs;
  var pointsOutModel = <PointsOutModel>[].obs;
  var summaryModel = <SummaryModel>[].obs;
  var points_in_tmModel = <PointsInTMModel>[].obs;
  var points_out_tmModel = <PointsOutTmModel>[].obs;
  var points_summary_tmModel = <SummaryTmModel>[].obs;
  var allTimeBlncModel = <AllTimeBlncModel>[].obs;
  var thisMonthBlncModel = <ThisMonthBlncModel>[].obs;
  var DATAURL = '${AppUrls.BASEURL}/getdata';

  //this month tabs data
  Future<void> thisMonthPointsI() async {

    try {
      response = await dio.post(
        DATAURL,
        data: {
          "SPNAME": "CRMMAP_WalletSP",
          "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
          "ReportQueryValue": ["0", "6", "${box.read('userNumber')}"]
        },
      );
      if (response.statusCode == 200) {
        tmDateResponse = jsonDecode(await response.data);
        points_in_tmModel.addAll(
            tmDateResponse.map((e) => PointsInTMModel.fromJson(e)).toList());
        isLoading.value = false;
      }
    } on DioError catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> thisMonthPointsO() async {
    try {
      response = await dio.post(
        DATAURL,
        data: {
          "SPNAME": "CRMMAP_WalletSP",
          "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
          "ReportQueryValue": ["0", "7", "${box.read('userNumber')}"]
        },
      );
      if (response.statusCode == 200) {
        tmDesResponse = jsonDecode(await response.data);
        points_out_tmModel.addAll(
            tmDesResponse.map((e) => PointsOutTmModel.fromJson(e)).toList());

        isLoading.value = false;
      }
    } on DioError catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> thisMonthSummary() async {
    try {
      response = await dio.post(
        DATAURL,
        data: {
          "SPNAME": "CRMMAP_WalletSP",
          "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
          "ReportQueryValue": ["0", "8", "${box.read('userNumber')}"]
        },
      );
      if (response.statusCode == 200) {
        tmAmountResponse = jsonDecode(await response.data);
        points_summary_tmModel.addAll(
        tmAmountResponse.map((e) => SummaryTmModel.fromJson(e)).toList());

        isLoading.value = false;
      }
    } on DioError catch (e) {
      isLoading.value = false;
    }
  }

  //all time tabs data
  Future<void> allTimePointsIn() async {
    try {
      response = await dio.post(
        DATAURL,
        data: {
          "SPNAME": "CRMMAP_WalletSP",
          "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
          "ReportQueryValue": ["0", "9", "${box.read('userNumber')}"]
        },
      );
      if (response.statusCode == 200) {
        responseData = jsonDecode(await response.data);
        pointsInModel.addAll(
            responseData.map((e) => PointsInModel.fromJson(e)).toList());

        isLoading.value = false;
      }
    } on DioError catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> allTimePointsOut() async {
    try {
      response = await dio.post(
        DATAURL,
        data: {
          "SPNAME": "CRMMAP_WalletSP",
          "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
          "ReportQueryValue": ["0", "10", "${box.read('userNumber')}"]
        },
      );
      if (response.statusCode == 200) {
        responseData1 = jsonDecode(await response.data);
        pointsOutModel.addAll(
            responseData1.map((e) => PointsOutModel.fromJson(e)).toList());

        isLoading.value = false;
      }
    } on DioError catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> allSummary() async {
    try {
      response = await dio.post(
        DATAURL,
        data: {
          "SPNAME": "CRMMAP_WalletSP",
          "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
          "ReportQueryValue": ["0", "11", "${box.read('userNumber')}"]
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        responseData2 = jsonDecode(await response.data);
        summaryModel.addAll(
            responseData2.map((e) => SummaryModel.fromJson(e)).toList());

      }
    } on DioError catch (e) {
      isLoading.value = false;
    }
  }

  //getAllTimeBalance
  Future<void> getAlltimeBlnc() async{
    var data = {"SPNAME": "CRMMAP_WalletSP",
      "ReportQueryParameters":["@nType","@nsType","@ContactNo"],
      "ReportQueryValue":["0","22","${box.read('userNumber')}"]
    };
    tABalanceRepo.allTimeRepo(data).then((value) =>{
      allTimeBlncList = jsonDecode(value),
      for(var element in allTimeBlncList){
        allTimeBlncModel.add(AllTimeBlncModel.fromJson(element))
      },
      allTimeOBlnc.value = '${allTimeBlncModel[0].openingBalance}',
      allTimeCBlnc.value = '${allTimeBlncModel[0].closingBalance}',
    });
  }
  Future<void> getThisMonthBlnc() async{
    var data = {"SPNAME": "CRMMAP_WalletSP",
      "ReportQueryParameters":["@nType","@nsType","@ContactNo"],
      "ReportQueryValue":["0","23","${box.read('userNumber')}"]
    };
    tABalanceRepo.thisMonthRepo(data).then((value) =>{
      thisMonthBlncList = jsonDecode(value),
      for(var element in thisMonthBlncList){
        thisMonthBlncModel.add(ThisMonthBlncModel.fromJson(element))
      },
      thisMonthOBlnc.value = '${thisMonthBlncModel[0].openingBalance}',
      thisMonthCBlnc.value = '${thisMonthBlncModel[0].closingBalance}',
    });
  }
}
