import 'dart:ui' as UI;

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_text.dart';
import 'constants.dart';

class Utils {
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    return BotToast.showText(
      text: message,
    );
  }

  static appSnackBar(
      {String? title,
      subtitle,
      Color? bgColor,
      txtColor,
      SnackPosition? snackPosition}) {
    return Get.snackbar(
      title ?? '',
      titleText: AppText(
        text: title ?? 'Alert',
        color: txtColor ?? Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      messageText: AppText(
        text: subtitle ?? 'Please Select Type',
        color: txtColor ?? Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      subtitle ?? '',
      snackPosition:snackPosition?? SnackPosition.TOP,
      backgroundColor: bgColor ?? Constants.SECONDRY_COLOR,

      colorText: txtColor ?? Colors.white,
    );
  }
}
extension CusTomeSize on num{
  SizedBox get ph => SizedBox(height: toDouble(),);
  SizedBox get pw => SizedBox(width: toDouble(),);
}