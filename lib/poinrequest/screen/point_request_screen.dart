import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_loader.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../common/custome_appbar.dart';
import '../../common/input_field.dart';
import '../../login/controller/login_controller.dart';
import '../../utils/app_button.dart';
import '../../utils/app_images.dart';
import '../../utils/constants.dart';
import '../controller/point_req_controller.dart';

class PointRequestScreen extends StatefulWidget {
  const PointRequestScreen({Key? key}) : super(key: key);

  @override
  State<PointRequestScreen> createState() => _PointRequestScreenState();
}

class _PointRequestScreenState extends State<PointRequestScreen> {
  var loginController = Get.put(LoginController());
  var pointRequestController = Get.find<PointRequestController>();
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pointRequestController.dashBRefreshPointRequest();
        Get.back();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.w, right: 16.w),
                  child: const SizedBox.shrink(),
                ),
                const CustomAppbar(title: 'Point Request',imgPath: AppImages.GET_POINTS_ICON,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: InputField(
                          controller: pointRequestController.pointController,
                          isShowTitle: true,
                          titleTxt: 'Request',
                          hintText: 'Points',
                          inputFormatter: [
                            // Limit input to digits only and apply custom thousands formatter
                            FilteringTextInputFormatter.digitsOnly,
                            ThousandsFormatter(),
                            LengthLimitingTextInputFormatter(9), // Limit input to 9 characters
                          ],
                          onChanged: (val) {
                            // No need to handle input formatting here as the custom input formatter will do it.
                          },
                        ),
                      ),
                      
                      Center(
                        child: AppButton(
                          btnText: 'Submit',
                          width: 0.8.sw,
                          color: Constants.PRIMARY_COLOR,
                          onPressed: () async {
                            if (pointRequestController.pointController.text.isEmpty ||
                                int.parse(pointRequestController.pointController.text.replaceAll(',', '')) <= 0) {
                              Utils.appSnackBar(subtitle: 'Please enter valid points');
                            } else {
                              appLoader(context, Constants.PRIMARY_COLOR);
                              var replaceComma = pointRequestController.pointController.text.replaceAll(',', '');
                              debugPrint('replaceComma: $replaceComma');
                              pointRequestController.submitPointRequest(
                                replaceComma,
                                pointRequestController.remarksController.text.trim(),
                              );
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 100.h,
                          child: Image.asset(AppImages.TQR_LOGO),
                        ),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int selectionIndex = newValue.selection.end;
    int commaCount = 0;
    final String text = newValue.text.replaceAll(',', '');
    final StringBuffer newText = StringBuffer();

    for (int i = text.length - 1; i >= 0; i--) {
      newText.write(text[i]);
      commaCount++;
      if (commaCount == 3 && i != 0) {
        newText.write(',');
        commaCount = 0;
      }
    }

    final String formattedText = newText.toString().split('').reversed.join('');
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
