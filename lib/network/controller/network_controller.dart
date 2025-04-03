
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class NetworkController extends GetxController {
  var connectionStatus = 0.obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;


  @override
  void onInit() {
    super.onInit();
    subscription = connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    initConnectivity();
  }
 Future<void> initConnectivity()async{
    ConnectivityResult result = ConnectivityResult.none;
    try{
      result = await connectivity.checkConnectivity();
    } on PlatformException catch(e) {
      debugPrint('----> $e');
    }
    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    switch (result){
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 1;
        break;
      case ConnectivityResult.none:
        Utils.appSnackBar(subtitle: 'No Internet Connection',);
        connectionStatus.value = 0;
        break;
      default:
        Utils.appSnackBar(subtitle: 'No Internet Connection',);
        break;
    }
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}