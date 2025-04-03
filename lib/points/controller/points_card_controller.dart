import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../repository/points_repo/points_repo.dart';
import '../model/pending_pt_model.dart';
import '../model/points_history_model.dart';

class PointsCardController extends GetxController{
  ScrollController scrollController = ScrollController();
  PointsRepo pointsRepo = PointsRepo();
  var pendingPointModel = <PendingPointModel>[].obs;
  var pointsHistoryModel = <PointHistoryModel>[].obs;
  List<dynamic> pendingPtList = [];
  List<dynamic> pointsHistoryList = [];
  final RxBool isLoading = true.obs;

  Future<void> refreshDataPendingPoints() async {
    pendingPointModel.clear();
    await getPendingPointData(); // Fetch fresh data
  }

  Future<void> refreshDataHistoryPoints() async {
   pointsHistoryModel.clear();
    await getPointHistoryData();
  }

  Future<void> getPendingPointData()async{
    var data = {"SPNAME": "CRMMAP_WalletSP",
      "ReportQueryParameters":["@nType","@nsType","@ContactNo"],
      "ReportQueryValue":["0","29","${box.read('userNumber')}"]
    };
    
    pointsRepo.pendingPointApi(data).then((value) {
     
      
      pendingPtList = jsonDecode(value);
      for(var element in pendingPtList){
        pendingPointModel.add(
          PendingPointModel.fromJson(element),
        );
      }
       isLoading.value = false;
      
    }).onError((error, stackTrace) {
      isLoading.value = false;
    });
  }

  Future<void> getPointHistoryData()async{
    var data = {"SPNAME": "CRMMAP_WalletSP",
      "ReportQueryParameters":["@nType","@nsType","@ContactNo"],
      "ReportQueryValue":["0","27","${box.read('userNumber')}"]
    };
    pointsRepo.pointHistoryApi(data).then((value) {
      isLoading.value = false;
      pointsHistoryList = jsonDecode(value);
      for(var element in pointsHistoryList){
        pointsHistoryModel.add(
          PointHistoryModel.fromJson(element),
        );
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
    });
  }
}