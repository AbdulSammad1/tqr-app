import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'Fonts/AppDimensions.dart';
import 'Fonts/font_weights.dart';
import 'constants.dart';



class LangToggleBtn extends StatelessWidget {
  final bool status;
  final Function(bool) onToggle;
  const LangToggleBtn({Key? key,this.status =false,required this.onToggle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: context.locale.toString() == 'ur'?85.w :85.w,
      height: 30.0,
      valueFontSize: AppDimensions.FONT_SIZE_11,
      toggleSize: 31.0,
      value: status,
      borderRadius: 30.0,
      padding:6,
      activeTextColor: Colors.white,
      inactiveTextColor: Colors.white,
      activeText: 'اردو',
      inactiveText: 'English',
      showOnOff: true,
      activeTextFontWeight: FontWeights.bold,
      activeColor: Constants.SECONDRY_COLOR,
      inactiveColor: Constants.SECONDRY_COLOR,
      duration: const Duration(milliseconds: 600),
      onToggle: onToggle,
    );
  }
}
