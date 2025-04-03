import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';

Widget urduSwitchWidget(){
  return Expanded(
    child: Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: AppText(
            text: 'اردو',
            fontSize:
            AppDimensions.FONT_SIZE_12,
            fontWeight: FontWeights.semiBold,
            color: Constants.WHITE_COLOR,
          ),
        ),
        Container(
          width: 25,
          height: 25,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),

      ],
    ),
  );
}

Widget englishSwitchWidget(){
  return Row(
    mainAxisAlignment:
    MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 25,
        height: 25,
        margin: EdgeInsets.only(right: 3.w),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
      AppText(
        text: 'English',
        fontSize:
        AppDimensions.FONT_SIZE_11,
        fontWeight: FontWeights.regular,
        color: Constants.WHITE_COLOR,
      ),
    ],
  );
}
