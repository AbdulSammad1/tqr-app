import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/res/routes/route_name.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/font_weights.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../distributor_login/controller/dsp_login_controller.dart';
import '../../main.dart';
import '../../phone/controller/phone_controller.dart';
import '../../utils/app_button.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/otp_controller.dart';

class OtpScreen extends StatefulWidget {
  final String? otpId, phoneNumber;

  const OtpScreen({Key? key, this.otpId, this.phoneNumber}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otpController = Get.find<OtpController>();
  final phoneController = Get.find<PhoneController>();
  var dspController  = Get.put(DspLoginController());
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;
  var data = Get.arguments;


  @override
  Widget build(BuildContext context) {
    var validationData = {"SPNAME": "CRMMAP_MasterSP",
      "ReportQueryParameters":["@nType", "@nsType","@OtpCode","@ContactNo"],
      "ReportQueryValue":["1","1","${data[0]}","${data[1]}"]
    };
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Directionality(
          textDirection: directionLtr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.w, right: 16.w),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 1),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 180.h,
                margin: EdgeInsets.only(top: 6.h),
                decoration: BoxDecoration(
                  color: Constants.PRIMARY_COLOR.withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.MOBILE_OTP_ICON,
                  color: Constants.WHITE_COLOR,
                  height: 80.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     AppText(
                      text: 'OTP',
                      fontSize: AppDimensions.FONT_SIZE_22,
                      fontWeight: FontWeights.semiBold,
                    ),
                    AppText(
                      text: 'Please enter the OTP sent to your mobile number',
                      fontSize: AppDimensions.FONT_SIZE_15,
                      fontWeight: FontWeights.medium,
                      color: Constants.GREY_COLOR,
                    ),
                  ],
                ),
              ),
              Container(
                height: 50.h,
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: OtpTextField(
                  numberOfFields: 4,
                  borderColor: Constants.DARK_GREY_COLOR,
                  textStyle:  TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                  ),
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  fieldWidth: 50.w,
                  showFieldAsBox: true,
                  focusedBorderColor: Constants.PRIMARY_COLOR,
                  cursorColor: Constants.PRIMARY_COLOR,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onCodeChanged: (val) {
                  },
                  onSubmit: (String pin) {
                    otpController.isValidate.value = true;
                    Future.delayed(const Duration(seconds: 1), () {
                      otpController.otpTextField = pin;
                      if (pin ==
                          otpController.resendToken.value) {
                        otpController.otpRepository.otpValidationApi(validationData).then((value) {
                          // debugPrint('----->onChanged: $value');
                        });
                        otpController.loginTrue = true;
                        box.write('userNumber', data[1]);
                        box.write('loginUser',
                            otpController.loginTrue == true ? 1 : 0);
                        box.write('isDLogin', dspController.iDLogin = false);
                        Get.offAllNamed(RouteName.bottomNavScreen);
                        Utils.appSnackBar(
                          title: 'Success',
                          subtitle: 'Login Successfully',
                          bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
                        );
                        otpController.isValidate.value = false;
                      } else {
                        otpController.isValidate.value = false;
                        Utils.appSnackBar(
                            title: 'Alert', subtitle: 'Invalid OTP');
                      }
                    });
                  }, // end onSubmit
                ),
              ),
              AppText(
                text: 'Dont\'t receive the OTP?',
                fontSize: AppDimensions.FONT_SIZE_15,
                fontWeight: FontWeights.medium,
                color: Constants.GREY_COLOR,
              ),
              TextButton(
                onPressed: () async {
                  otpController.resendOtpMethod();
                  FocusScope.of(context).unfocus();
                },
                child: Obx(() {
                  return AppText(
                    text: otpController.isResend.isTrue
                        ? 'wait...'
                        : 'Resend OTP',
                    fontSize: AppDimensions.FONT_SIZE_15,
                    fontWeight: FontWeights.medium,
                    color: Constants.SECONDRY_COLOR,
                    textDecoration: TextDecoration.underline,
                  );
                }),
              ),
              //submit btn
              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 0.w),
                  child: otpController.isValidate.isTrue
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Constants.PRIMARY_COLOR,
                          ),
                        )
                      : AppButton(
                          btnText: 'SUBMIT',
                          width: double.infinity,
                          color: Constants.PRIMARY_COLOR,
                          onPressed: () {
                            otpController.isValidate.value = true;
                            // debugPrint('--> ${otpController.otpTextField} --> ${data[0]}');
                            Future.delayed(const Duration(seconds: 1), () {
                              if ('${otpController.otpTextField}' ==
                                  otpController.resendToken.value) {
                                otpController.otpRepository.otpValidationApi(validationData).then((value) {
                                });
                                otpController.loginTrue = true;
                                box.write('isDLogin', dspController.iDLogin = false);
                                box.write('userNumber', data[1]);
                                box.write('loginUser',
                                    otpController.loginTrue == true ? 1 : 0);
                                Get.offAllNamed(RouteName.bottomNavScreen);
                                otpController.isValidate.value = false;
                              } else {
                                otpController.isValidate.value = false;
                                Utils.appSnackBar(
                                    title: 'Alert', subtitle: 'Invalid OTP');
                              }
                            });
                          },
                        ),
                );
              }),
              SizedBox(
                height: 10.h,
              ),
              AppText(
                text:
                    'In case of not receiving the code.\ncontact the given number',
                color: Constants.SECONDRY_COLOR,
                textAlign: TextAlign.center,
                fontSize: AppDimensions.FONT_SIZE_16,
                fontWeight: FontWeights.regular,
              ),
              SizedBox(
                height: 10.h,
              ),
              AppText(
                text: '02138657729',
                color: Constants.PRIMARY_COLOR,
                fontWeight: FontWeights.semiBold,
                fontSize: AppDimensions.FONT_SIZE_22,
              ),
              AppText(
                text: 'Time: 10 AM to 5:30 PM\nMonday to Saturday',
                color: Constants.BLACK_COLOR,
                textAlign: TextAlign.center,
                fontSize: AppDimensions.FONT_SIZE_17,
                fontWeight: FontWeights.semiBold,
              ),
              const Spacer(),
              SizedBox(
                height: 100.w,
                child: Image.asset(AppImages.TQR_LOGO),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
