import 'dart:convert';
import 'dart:math';
import 'dart:ui' as UI;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../dashboard/controller/dashboard_controller.dart';
import '../../distributor_login/controller/dsp_login_controller.dart';
import '../../main.dart';
import '../../repository/dsp_retailer_login_repo/dsp_retailer_login_repo.dart';
import '../../res/routes/route_name.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_button.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../model/dsp_retailer_login_model.dart';

class DspRetailerLoginController extends GetxController {
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;
  var dspLoginController = Get.put(DspLoginController());
  var numberController = TextEditingController();
  var otpTextFieldNum;
  var dashboardController = Get.find<DashboardController>();
  DspRetailerLoginRepo dspRetailerLoginRepo = DspRetailerLoginRepo();
  var dspRetailerLoginModel = <DspRetailerLoginModel>[].obs;
  List<dynamic> dspRetailerLoginLit = [].obs;

  var random = Random();
  var otpNum = 1244;
  var countryCode = '92';
  var phoneNumber;
  String replaceNum = '';
  var dspNum;
  var replaceNum1;
  var retailerNum;
  var retailerName;
  var isLogin = false.obs;

  void getDistributorNum() {
    dspNum = dashboardController.distributorNum;
  }

  void generateRandomNum() {
    otpNum = random.nextInt(9999);
    if (otpNum < 1000) {
      otpNum = otpNum + 1000;
      debugPrint('>>>>>>otp num: $otpNum');
    } else {
      debugPrint('>>>>>> $otpNum <<<<<');
    }
  }

  Future<void> dspRetailerLoginMethod(var num, BuildContext context) async {
    isLogin.value = true;
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
    dspRetailerLoginRepo.dspRetailerLoginApi(data).then((valueRetailer) {
      dspRetailerLoginLit = jsonDecode(valueRetailer);
      print('helo ${dspRetailerLoginLit[0]['Deviceid']}');

      var deviceId = dspRetailerLoginLit[0]['Deviceid'];

       print('dd Id1: $deviceId');

      if (dspRetailerLoginLit[0]['Status'] == 0) {
        Get.back();
        Utils.appSnackBar(
            bgColor: Colors.red,
            title: 'Error',
            subtitle: dspRetailerLoginLit[0]['MessageCaption']);

        // showDialogBox('Wrong Number', dspRetailerLoginLit[0]['MessageCaption']);
      } else {
        for (var i in dspRetailerLoginLit) {
          dspRetailerLoginModel.add(DspRetailerLoginModel.fromJson(i));
        }

        replaceNum1 = dspRetailerLoginModel[0].contactNo;
        retailerName = dspRetailerLoginModel[0].customerName;
        retailerNum = dspRetailerLoginModel[0].contactNo;

        // debugPrint('>>>>>>>>retailer login from admi  n $valueRetailer    num $replaceNum1');
        if (replaceNum1 != null) {
          var smsData = {
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
              "10",
              "$phoneNumber",
              "$otpNum",
              "$deviceId-$phoneNumber",
              "MA-RT",
              "111"
            ]
          };
          Future.delayed(const Duration(milliseconds: 400)).then((value) {
            dspRetailerLoginRepo.dspRetailerOTPApi(smsData).then((value) {
              var smsResponse = jsonDecode(value);
              var smsApi = smsResponse[0]["SMSApi"];

              // Replace '\u0026' with '&' in the SMS API URL
              smsApi = smsApi.replaceAll(r"\u0026", "&");

              // Send the SMS API request in the background using http.get
              _sendSMSApiRequest(smsApi);

              print('sms respo:${smsResponse[0]['SMSApi']}');

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      mainAxisAlignment: context.locale == const Locale('en')
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 30,
                          ),
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            isLogin.value = false;
                            dspLoginController.verifyOtp.value = false;
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    scrollable: true,
                    insetPadding: EdgeInsets.zero,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    titlePadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    content: Container(
                        height: 250.h,
                        width: 340.w,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: AppText(
                                text: 'Enter OTP',
                                fontSize: AppDimensions.FONT_SIZE_18,
                                color: Constants.BLACK_COLOR,
                                fontWeight: FontWeights.semiBold,
                              ),
                            ),
                            Directionality(
                              textDirection: directionLtr,
                              child: Expanded(
                                child: Container(
                                  height: 45,
                                  margin:
                                      EdgeInsets.only(top: 25.w, bottom: 10.h),
                                  child: OtpTextField(
                                    numberOfFields: 4,
                                    enabledBorderColor: Constants.PRIMARY_COLOR,
                                    borderColor: Constants.PRIMARY_COLOR,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    fieldWidth: 50,
                                    showFieldAsBox: true,
                                    focusedBorderColor: Constants.PRIMARY_COLOR,
                                    cursorColor: Constants.PRIMARY_COLOR,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    onSubmit: (String pin) {
                                      otpTextFieldNum = pin;
                                      // logger.i('----->onSubmit: $otpTextFieldNum');
                                    }, // end onSubmit
                                  ),
                                ),
                              ),
                            ),
                            Obx(() {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 22.w,
                                  right: 22.w,
                                  bottom: 60.h,
                                ),
                                child: dspLoginController.verifyOtp.isTrue
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: Constants.PRIMARY_COLOR,
                                        ),
                                      )
                                    : AppButton(
                                        btnText: 'Verify',
                                        width: double.infinity,
                                        color: Constants.SECONDRY_COLOR,
                                        onPressed: () {
                                          var name = dspRetailerLoginModel[0]
                                              .customerName;
                                          var contactNo =
                                              dspRetailerLoginModel[0]
                                                  .contactNo;
                                          // debugPrint('>>>> $name  ||| $contactNo');
                                          dspLoginController.verifyOtp.value =
                                              true;
                                          var verifyOtp = {
                                            "SPNAME": "CRMMAP_MasterSP",
                                            "ReportQueryParameters": [
                                              "@nType",
                                              "@nsType",
                                              "@OtpCode",
                                              "@ContactNo"
                                            ],
                                            "ReportQueryValue": [
                                              "0",
                                              "5",
                                              "$otpNum",
                                              "$replaceNum1"
                                            ]
                                          };

                                          print('ver $verifyOtp');

                                           print('dd Id: $deviceId');

                                          if (otpTextFieldNum ==
                                              otpNum.toString()) {
                                            isLogin.value = false;
                                            box.write(
                                                'retailerDevicekey', deviceId);

                                            box.write(
                                                'userNumber', retailerNum);
                                            box.write(
                                                'aRetailerName', retailerName);
                                            Future.delayed(
                                                    const Duration(seconds: 1))
                                                .then((value) {
                                              dspRetailerLoginRepo
                                                  .dspRetailerOTPApi(verifyOtp)
                                                  .then((value) {
                                                Navigator.pop(context);
                                                dspLoginController
                                                    .verifyOtp.value = false;
                                                // logger.i("otp update");
                                                box.write(
                                                    'dspRlogin',
                                                    dspLoginController
                                                        .dspRLogin = true);
                                                box.write(
                                                    'dotBtn',
                                                    dspLoginController
                                                        .showDotBtn = false);
                                                box.write(
                                                    'isDLogin',
                                                    dspLoginController.iDLogin =
                                                        false);
                                                //  logger.i('isDLogin<<<<<<<< ${dspLoginController.iDLogin}');
                                                box.write('isDistributorLogin',
                                                    false);
                                                Future.delayed(const Duration(
                                                        milliseconds: 400))
                                                    .then((value) {
                                                  box.write(
                                                      'retailerName', name);
                                                  box.write('retailerPhone',
                                                      contactNo);
                                                  Utils.appSnackBar(
                                                    title: 'Success',
                                                    subtitle: 'OTP Verified',
                                                    bgColor: Constants
                                                        .PRIMARY_COLOR
                                                        .withOpacity(0.8),
                                                  );
                                                  Get.offAllNamed(RouteName
                                                      .bottomNavScreen);
                                                });
                                              });
                                            });
                                          } else {
                                            dspLoginController.verifyOtp.value =
                                                false;
                                            Utils.appSnackBar(
                                              title: 'Warning',
                                              subtitle:
                                                  'Please enter correct OTP',
                                            );
                                          }
                                        },
                                      ),
                              );
                            }),
                          ],
                        )),
                  );
                },
              );
              logger.i('sms send $value');
            });
          });
        } else {
          // debugPrint("Retailer Number is null");
        }
      }

      // logger.i('retailer login data $valueRetailer----- num $replaceNum1');
    }).onError((error, stackTrace) {
      isLogin.value = false;
      dspLoginController.verifyOtp.value = false;
      Utils.appSnackBar(
        title: 'Warning',
        subtitle: 'Please enter correct number',
      );
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
}
