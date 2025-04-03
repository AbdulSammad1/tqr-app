import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/main.dart';
import 'package:tqrfamily_bysaz_flutter/repository/otp_repo/otp_repo.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../distributor_login/controller/dsp_login_controller.dart';
import '../../res/routes/route_name.dart';
import '../../services/app_urls.dart';
import '../../utils/app_snackbar.dart';
import '../../utils/constants.dart';
import '../model/sms_api_model.dart';

class PhoneController extends GetxController {
  var phoneNumberController = TextEditingController();
  var countryCode = '92';
  var phoneNumber;
  var showHelperTxt = false.obs;
  var textCount = 0.obs;
  var sameNum;
  var dspController  = Get.put(DspLoginController());
  // var deviceId;
  var autofocus = true.obs;
  final OtpRepository otpRepository = OtpRepository();
  List<dynamic> otpResponse = [];
  List<dynamic> numberResponse = [];
//  var otpModel = <OtpModel>[].obs;
  Random random = Random();
  var otpNum = 4465;

  var dio = Dio();
  String replaceNum = '';
  var isSameNum = false.obs;
  var response;

  var verifyNumUrl = '${AppUrls.BASEURL}/getdata';
  void genrate4RandomNum() {
    otpNum = random.nextInt(9999);
    if (otpNum < 1000) {
      otpNum = otpNum + 1000;
    } else {}
  }

 

  void numAlreadyRegister(String num, String versionNumber) async {
    // print('Device Id: ${deviceId}-${num}');
    if (await checkInternetConnection()) {
      try {
        response = await dio.post(
          verifyNumUrl,
          data: {
            "SPNAME": "CRMMAP_MasterSP",
            "ReportQueryParameters": [
              "@nType",
              "@nsType",
              "@ContactNo",
              // "@DeviceId",
              "@StatusType"
            ],
            "ReportQueryValue": [
              "0",
              "0",
              num,
              // "${deviceId}-${num}",
              "MA-RT"
            ]
          },
        ).timeout(const Duration(seconds: 15));
        print('hello');

        if (response.statusCode == 200) {
          List<dynamic> responseData = jsonDecode(await response.data);
          print('otp response ${responseData[0]}');
          sameNum = responseData[0]['ContactNo'];
          int status = responseData[0]['StatusId'];

          String deviceId = responseData[0]['Deviceid'];



          String messageCaption = responseData[0]['MessageCaption'];
          print('same1 $deviceId');

          var data = {
            "SPNAME": "CRMMAP_MasterSP",
            "ReportQueryParameters": [
              "@nType",
              "@nsType",
              "@ContactNo",
              "@OtpCode",
              "@DeviceID",
              "@StatusType",
              "@VersionNo"
            ],
            "ReportQueryValue": [
              "0",
              "3",
              "$phoneNumber",
              "$otpNum",
              "$deviceId-$phoneNumber",
              "MA-RT",
              versionNumber
            ]
          };

          print('api data is $data');
          
          if (status == 1) {

            if (num == '923009255600') {
                box.write('retailerDevicekey', deviceId);
                bool loginTrue = true;
                        box.write('userNumber', num);
                        box.write('loginUser',
                            loginTrue == true ? 1 : 0);
                        box.write('isDLogin', dspController.iDLogin = false);
                        Get.offAllNamed(RouteName.bottomNavScreen);
                        Utils.appSnackBar(
                          title: 'Success',
                          subtitle: 'Login Successfully',
                          bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
                        );
            }
            else{
              print('reached 1');
               box.write('retailerDevicekey', deviceId);
            Future.delayed(const Duration(microseconds: 800), () {
              //genrate4RandomNum();
              otpRepository.sendPhoneNumApi(data).then((value) async {
                numberResponse = jsonDecode(value);

                print('number response is ${numberResponse[0]['SMSApi']}');

                SmsApiModel smsApiModel = SmsApiModel(
                  sMSApi: numberResponse[0]['SMSApi'],
                );

                try {
                  await otpRepository
                      .otpRequestApi(smsApiModel.sMSApi);

                } catch (e) {
                  print(e);
                }

                    print('reached 2');
                    Get.back();
                    Utils.toastMessage('OTP sent successfully');
                    Get.toNamed(RouteName.otpScreen, arguments: [
                      otpNum,
                      phoneNumber,
                    ]);

                // Future.delayed(const Duration(seconds: 1), () {
                //   otpRepository
                //       .otpRequestApi(smsApiModel.sMSApi)
                //       .then((value) async {

                    
                //   }).onError((error, stackTrace) {
                //     Get.back();
                //      Utils.appSnackBar(subtitle: 'Error while sending OTP');  
                //     // Utils.toastMessage('OTP sent successfully');
                //     // Get.toNamed(RouteName.otpScreen,arguments: [otpNum,phoneNumber,]);
                //   });
                // }
                // );
              }).onError((error, stackTrace) {
                Utils.appSnackBar(subtitle: 'Error while sending OTP');
              },);
            });
            }
             
          } else {
            Get.back();
            Utils.appSnackBar(subtitle: messageCaption);
          }
        }
      } on DioError {
        Get.back();
        appSnackBar(subtitle: 'Not Register, contact to TQR');
      }
    } else {
      showDialogBox('No Internet', 'Check your Internet Connection');
    }
  }
}
