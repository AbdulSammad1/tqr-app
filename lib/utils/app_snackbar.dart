import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

SnackbarController appSnackBar({String? title, subtitle}){
  return Get.snackbar(
    title??'Alert',
    subtitle??'Please Select Type',
    snackPosition: SnackPosition.TOP,
    backgroundColor: Constants.SECONDRY_COLOR,
    colorText: Colors.white,
  );
}