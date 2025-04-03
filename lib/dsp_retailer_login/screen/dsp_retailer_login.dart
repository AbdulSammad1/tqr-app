import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_button.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_text.dart';

import '../../common/input_field.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../distributor_login/controller/dsp_login_controller.dart';
import '../../main.dart';
import '../../res/routes/route_name.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../controller/dsp_retailer_controller.dart';

class DspRetailerLogin extends StatelessWidget {
  const DspRetailerLogin({super.key});

  

  @override
  Widget build(BuildContext context) {
    var dspRetailerController = Get.find<DspRetailerLoginController>();
    var dashboardController = Get.find<DashboardController>();
    var dspLoginController = Get.put(DspLoginController());
    

    UI.TextDirection directionLtr = UI.TextDirection.ltr;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 200.w,
                child: Image.asset(AppImages.TQR_LOGO),
              ),
            ),
            box.read('retailerName') == null ? const SizedBox.shrink() :  AppText(
              text: box.read('retailerName'),
              fontSize: AppDimensions.FONT_SIZE_18,
              fontWeight: FontWeights.semiBold,
            ),
            box.read('retailerName') == null ? const SizedBox.shrink() :   Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AppText(
                text: box.read('retailerPhone'),
                fontSize: AppDimensions.FONT_SIZE_18,
                fontWeight: FontWeights.semiBold,
              ),
            ),
            Expanded(
              child: Directionality(
                textDirection: directionLtr,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    box.read('dotBtn') == true ?  const  Spacer() : const SizedBox.shrink(),
                    box.read('dotBtn') == true ?  AppText(
                      text: 'Please enter number to login',
                      fontSize: AppDimensions.FONT_SIZE_18,
                      fontWeight: FontWeights.semiBold,
                    ) : const SizedBox.shrink(),
                    box.read('dotBtn') == true ?  SizedBox(
                      height: 00.w,
                    ) : const SizedBox.shrink(),
                    box.read('dotBtn') == true ?  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.w),
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              text: '+92',
                              color: Constants.BLACK_COLOR,
                              fontSize: AppDimensions.FONT_SIZE_21,
                            ),
                            SizedBox(
                              width: 200.w,
                              child: InputField(
                                controller:
                                    dspRetailerController.numberController,
                                isShowTitle: false,
                                
                                hintText: 'Enter retailer number',
                                // inputFormatter: [
                                //   //limit to 6 characters
                                //   LengthLimitingTextInputFormatter(10),
                                // ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) : const SizedBox.shrink(),
                    box.read('dotBtn') == true ?  Obx(() {
                      return dspRetailerController.isLogin.isTrue
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Constants.PRIMARY_COLOR,
                              ),
                            )
                          : AppButton(
                              btnText: 'Retailer Login',
                              onPressed: () {
                                if (dspRetailerController
                                    .numberController.text.isEmpty) {
                                  Utils.appSnackBar(
                                      title: 'Alert',
                                      subtitle:
                                          'Please enter retailer number');
                                } else {
                                  dspRetailerController.generateRandomNum();
                                  dspRetailerController.phoneNumber =
                                      dspRetailerController.countryCode +
                                          dspRetailerController
                                              .numberController.text;
                                              
                                  dspRetailerController.replaceNum =
                                      dspRetailerController.phoneNumber
                                          .replaceAll('+', '');
                                  debugPrint("----->replaceNum: ${dspRetailerController.phoneNumber}");
                                  dspRetailerController
                                      .dspRetailerLoginMethod(
                                          dspRetailerController.replaceNum,
                                          context);
                                }
                              },
                            );
                    }) :  Align(
                      alignment:  Alignment.center,
                      child: AppButton(
                        btnText: 'Retailer Logout',
                        onPressed: () {
                          // debugPrint("----->admin number: ${dashboardController.adminNum}");
                          
                          box.write('userNumber', dashboardController.adminNum);
                          box.write('dspRlogin',false);
                          box.write('isDistributorLogin', true);
                          box.write('isDLogin', dspLoginController.iDLogin = true);
                          //  logger.w('isDLogin:<><><><><> ${box.read('isDLogin')}');
                          box.write('dotBtn', dspLoginController.showDotBtn= true);
                          box.remove('retailerName');
                          box.remove('retailerPhone');
                          Future.delayed(const Duration(milliseconds: 600)).then((value) =>  Get.offAllNamed(RouteName.bottomNavScreen,));
                        },
                      ),
                    ),
                    box.read('dotBtn') == true ? const  Spacer(flex: 2,) : const SizedBox.shrink(),
                    
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
