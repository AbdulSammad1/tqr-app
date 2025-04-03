import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tqrfamily_bysaz_flutter/transfer_points/model/transfer_model.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../main.dart';
import '../../poinrequest/controller/point_req_controller.dart';
import '../../repository/transfer_points_repo/otp_success_repo.dart';
import '../../repository/transfer_points_repo/transfer_points_repo.dart';
import '../../repository/transfer_points_repo/transferpt_sms_repo.dart';
import '../model/pt_validate_model.dart';
import '../widgets/success_dialog_widget.dart';

class TransferPointsController extends GetxController {
  var pointRequestController = Get.find<PointRequestController>();
  var pointController = TextEditingController();
  var remarkController = TextEditingController();
  var retailerController = TextEditingController();
  var countryCode = '92';
  var phoneNumber;
  String replaceNum = '';
  var isPendingRequest = false.obs;

  final NumberFormat formatter = NumberFormat('#,##0');
  var transferModelList = <TransferPointModel>[].obs;
  var pointsValidateModel = <PointsValidateModel>[].obs;
  var isBuy = false.obs;
  var isGet = false.obs;
  List<dynamic> transferPointList = [];
  List<dynamic> maxPointsList = [];
  List<dynamic> numberResponse = [];
  var maxPointsAllowed = 0.obs;
  var memberName = ''.obs;
  var memberRegion = ''.obs;
  var memberCity = ''.obs;
  var memberStatus = ''.obs;
  var memberMessage = ''.obs;
  var memberArea = ''.obs;
  RxString? selectedValue = 'Select Scheme'.obs;
  final TransferPointsRepo _transferPointsRepo = TransferPointsRepo();
  var name = ''.obs;
  var random = Random();
  var otpNum = 1244;
  var otpTextFieldNum;
  TransferPSmsRepo transferPSmsRepo = TransferPSmsRepo();
  OtpSuccessRepo otpSuccessRepo = OtpSuccessRepo();

  void generateRandomNum() {
    otpNum = random.nextInt(9999);
    if (otpNum < 1000) {
      otpNum = otpNum + 1000;
      // print('>>>>>>otp num: $otpNum');
    } else {
      // print('>>>>>> $otpNum <<<<<');
    }
  }

  void clearUserData() {
    // Clear the user data by resetting the relevant variables
    transferModelList.clear();
    memberName.value = '';
    memberRegion.value = '';
    memberCity.value = '';
    memberArea.value = '';
    // You can add more variables to reset if needed

    // Notify the UI that the data has changed
    update();
  }

  Future<void> transferPointApi(
    var num,
  ) async {
    isGet.value = true;
    var data = {
      "SPNAME": "CRMMAP_WalletSP",
      "ReportQueryParameters": [
        "@nType",
        "@nsType",
        "@ParentContactNo",
        "@RetailerContactNo"
      ],
      "ReportQueryValue": ["0", "18", "${box.read('userNumber')}", "$num"]
    };

    _transferPointsRepo.transferPointApi(data).then((value1) {
      transferPointList = jsonDecode(value1);
      print('hello $transferPointList');
      transferModelList.addAll(transferPointList
          .map((e) => TransferPointModel.fromJson(e))
          .toList());
      for (var i in transferModelList) {
        i.status == 0
            ? showDialog(
                context: Get.context!,
                builder: (ctx) => AlertDialog(
                  title: const Text(
                    'Error',
                    style: TextStyle(color: Colors.black),
                  ),
                  content: Text(
                    i.message!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        isGet.value = false;
                        clearUserData();
                        Get.back();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              )
            : memberName.value = '${i.customerName}';
        memberRegion.value = '${i.region}';
        memberCity.value = '${i.city}';
        memberStatus.value = '${i.status}';
        memberArea.value = '${i.areaName}';
        update();
      }
      isGet.value = false;
    }).onError((error, stackTrace) {
      isGet.value = false;
      Utils.appSnackBar(
          title: 'Error', subtitle: 'Please enter correct number');
      clearUserData();
    });
  }

  Future<bool> checkRetailerNumber(String retailerNumber) async {
    try {
      var data = {
        "SPNAME": "CRMMAP_WalletSP",
        "ReportQueryParameters": [
          "@nType",
          "@nsType",
          "@ParentContactNo",
          "@RetailerContactNo"
        ],
        "ReportQueryValue": [
          "0",
          "18",
          "${box.read('userNumber')}",
          retailerNumber
        ]
      };

      final value1 = await _transferPointsRepo.transferPointApi(data);
      List<dynamic> transferPointList = jsonDecode(value1);

      if (transferPointList[0]['Status'] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  void transferPtValidate(
    var points,
    retailerNum,
    var reqTransNo,
    BuildContext context,
  ) {
    isBuy.value = true;
    var data = {
      "SPNAME": "CRMMAP_WalletSP",
      "ReportQueryParameters": [
        "@nType",
        "@nsType",
        "@ContactNo",
        "@ParaQty",
        "@Remarks",
        "@RequestTransacitonNo",
      ],
      "ReportQueryValue": [
        "0",
        "19",
        "$retailerNum",
        "$points",
        '',
        '${reqTransNo ?? ''}'
      ]
    };
    var smsData = {
      "SPNAME": "CRMMAP_MasterSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@OtpCode", "@ContactNo"],
      "ReportQueryValue": ["0", "5", "$otpNum", "$retailerNum"]
    };
    var otpSuccessData = {
      "SPNAME": "CRMMAP_MasterSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@OtpCode", "@ContactNo"],
      "ReportQueryValue": ["0", "6", "$otpNum", "$retailerNum"]
    };
    Future.delayed(const Duration(microseconds: 400)).then((value) {
      _transferPointsRepo.transferPtValidateApi(data).then((value) {
        maxPointsList = jsonDecode(value);
        pointsValidateModel.addAll(
            maxPointsList.map((e) => PointsValidateModel.fromJson(e)).toList());
        debugPrint('----> pointsValidateModel: $pointsValidateModel');
        var message = pointsValidateModel[0].messagebox;
        var status = pointsValidateModel[0].status;
        if (status == 1) {
          pointRequestController.verifyOtp.value = false;
          otpSuccessRepo.otpSuccessApi(otpSuccessData).then((value) => {
                isBuy.value = false,
                Future.delayed(const Duration(milliseconds: 300), () {
                  // Get.back();
                  pointRequestController.verifyOtp.value = false;
                  pointRequestController.dashBRefreshPointRequest();
                }),

                // Utils.toastMessage(
                //     'Points Transfer Successfully'),
                debugPrint('success'),
                Future.delayed(const Duration(seconds: 1)).then(
                  (value) => Get.back(),
                ),
              });
        } else if (status == 0) {
          pointRequestController.verifyOtp.value = false;
          isBuy.value = false;
          Utils.appSnackBar(subtitle: '$message');
        } else {
          pointRequestController.verifyOtp.value = false;
          isBuy.value = false;
          Utils.appSnackBar(
              subtitle: 'Something went wrong, please try again later');
        }
      }).onError((error, stackTrace) {
        isBuy.value = false;
        debugPrint('##3######3error: $error');
      });
    });
  }

  Future<bool> transferPtValidateBool(
    var points,
    retailerNum,
    var reqTransNo,
    BuildContext context,
  ) async {
    isBuy.value = true;
    var data = {
      "SPNAME": "CRMMAP_WalletSP",
      "ReportQueryParameters": [
        "@nType",
        "@nsType",
        "@ContactNo",
        "@ParaQty",
        "@Remarks",
        "@RequestTransacitonNo",
      ],
      "ReportQueryValue": [
        "0",
        "19",
        "$retailerNum",
        "$points",
        '',
        '${reqTransNo ?? ''}'
      ] 
    };
    var smsData = {
      "SPNAME": "CRMMAP_MasterSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@OtpCode", "@ContactNo"],
      "ReportQueryValue": ["0", "5", "$otpNum", "$retailerNum"]
    };
    var otpSuccessData = {
      "SPNAME": "CRMMAP_MasterSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@OtpCode", "@ContactNo"],
      "ReportQueryValue": ["0", "6", "$otpNum", "$retailerNum"]
    };

    try {

      print('data is $data');
      // await Future.delayed(const Duration(microseconds: 400));
      var value = await _transferPointsRepo.transferPtValidateApi(data);
      maxPointsList = jsonDecode(value);
      pointsValidateModel.addAll(
          maxPointsList.map((e) => PointsValidateModel.fromJson(e)).toList());
      debugPrint('----> pointsValidateModel: $pointsValidateModel');
      var message = pointsValidateModel[0].messagebox;
      var status = pointsValidateModel[0].status;

      if (status == 1) {
        pointRequestController.verifyOtp.value = false;
        // await otpSuccessRepo.otpSuccessApi(otpSuccessData);
        isBuy.value = false;

        pointRequestController.verifyOtp.value = false;
        await pointRequestController.dashBRefreshPointRequest();

        // Get.back();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessDialog(
              receiverName: transferModelList[0].customerName.toString(),
              receiverNo: retailerNum,
              amount: points,
              heading: 'Points transferred',
              city: memberCity.value,
              onTap: () {
                Get.back();
              },
            );
          },
        );

        debugPrint('success');
        // await Future.delayed(const Duration(seconds: 1));
        // Get.back();
        return true;
      } else if (status == 0) {
        pointRequestController.verifyOtp.value = false;
        isBuy.value = false;
        Utils.appSnackBar(subtitle: '$message');
        return false;
      } else {
        pointRequestController.verifyOtp.value = false;
        isBuy.value = false;
        Utils.appSnackBar(
            subtitle: 'Something went wrong, please try again later');
        return false;
      }
    } catch (error) {
      isBuy.value = false;
      debugPrint('Error: $error');
      return false;
    } finally {}
  }

  void performTransfer(data) {
    _transferPointsRepo.transferPtValidateApi(data).then((value) {
      maxPointsList = jsonDecode(value);
      pointsValidateModel.addAll(
          maxPointsList.map((e) => PointsValidateModel.fromJson(e)).toList());
      debugPrint('----> pointsValidateModel: $pointsValidateModel');
      var message = pointsValidateModel[0].messagebox;
      var status = pointsValidateModel[0].status;
      if (status == 1) {
        pointRequestController.verifyOtp.value = false;
        isBuy.value = false;
        Future.delayed(const Duration(milliseconds: 300), () {
          pointRequestController.verifyOtp.value = false;
          pointRequestController.dashBRefreshPointRequest();
        });
        Utils.toastMessage('Points Transfer Successfully');
        debugPrint('success');
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
      } else if (status == 0) {
        pointRequestController.verifyOtp.value = false;
        isBuy.value = false;
        Utils.appSnackBar(subtitle: '$message');
      } else {
        pointRequestController.verifyOtp.value = false;
        isBuy.value = false;
        Utils.appSnackBar(
            subtitle: 'Something went wrong, please try again later');
      }
    }).onError((error, stackTrace) {
      isBuy.value = false;
      debugPrint('##3######3error: $error');
    });
  }

  Future<void> _sendSMSApiRequest(String smsApi) async {
    try {
      final response = await http.get(Uri.parse(smsApi));

      if (response.statusCode == 200) {
        // The GET request was successful, handle the response if needed
        logger.i('SMS API Response: ${response.body}');
      } else {
        // Handle the error if the request fails
        logger.e(
            'Failed to send SMS API request. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      logger.e('Error while sending SMS API request: $e');
    }
  }

  @override
  void onClose() {
    pointController.dispose();
    retailerController.dispose();
    super.onClose();
  }
}
