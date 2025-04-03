
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';

Widget openBalanceEng(var openingAmountTxt,closingAmountTxt){
  return Row(
    children: [
      Expanded(
        child: Container(
         // margin: EdgeInsets.only(top: 10.h),
          decoration: BoxDecoration(
            color: Constants.SECONDRY_COLOR,
          ),
          padding: EdgeInsets.symmetric(vertical: 5.h),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppText(text: 'Opening Balance',
                fontSize: AppDimensions.FONT_SIZE_14.sp,
                color: Constants.WHITE_COLOR,
                fontWeight: FontWeights.semiBold,),
              AppText(text: '$openingAmountTxt',
                fontSize: AppDimensions.FONT_SIZE_14.sp,
                color: Constants.WHITE_COLOR,
                fontWeight: FontWeights.semiBold,),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          decoration: BoxDecoration(
            color: Constants.GREEN_COLOR,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppText(text: 'Closing Balance',
                fontSize: AppDimensions.FONT_SIZE_14.sp,
                color: Constants.WHITE_COLOR,
                fontWeight: FontWeights.semiBold,),
              AppText(text: '$closingAmountTxt',
                fontSize: AppDimensions.FONT_SIZE_14.sp,
                color: Constants.WHITE_COLOR,
                fontWeight: FontWeights.semiBold,),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget openBalanceUr( var openingAmountTxt,closingAmountTxt){
  return Row(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
      //    margin: EdgeInsets.only(top: 10.h),
          decoration: BoxDecoration(
            color: Constants.GREEN_COLOR,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppText(text: 'Closing Balance',
                fontSize: AppDimensions.FONT_SIZE_14.sp,
                color: Constants.WHITE_COLOR,
                fontWeight: FontWeights.semiBold,),
              AppText(text: '$closingAmountTxt',
                fontSize: AppDimensions.FONT_SIZE_14.sp,
                color: Constants.WHITE_COLOR,
                fontWeight: FontWeights.semiBold,),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          decoration: BoxDecoration(
            color: Constants.SECONDRY_COLOR,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppText(text: 'Opening Balance',
                fontSize: AppDimensions.FONT_SIZE_14.sp,
                color: Constants.WHITE_COLOR,
                fontWeight: FontWeights.semiBold,),
              AppText(text: '$openingAmountTxt',
                fontSize: AppDimensions.FONT_SIZE_14.sp,
                color: Constants.WHITE_COLOR,
                fontWeight: FontWeights.semiBold,),
            ],
          ),
        ),
      ),
    ],
  );
}