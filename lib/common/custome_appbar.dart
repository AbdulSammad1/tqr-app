import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/Fonts/AppDimensions.dart';
import '../utils/Fonts/font_weights.dart';
import '../utils/app_images.dart';
import '../utils/app_text.dart';
import '../utils/constants.dart';

class CustomAppbar extends StatelessWidget {
  final String? title, imgPath;
  final double? height;
  final double?  width;
  final double? buttonWidth;
  final Color? color;
  final bool? showBackButton;

  const CustomAppbar(
      {Key? key,
      this.title,
      this.imgPath,
      this.height,
      this.width,
      this.buttonWidth,
      this.color, this.showBackButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      margin: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
        color: Constants.PRIMARY_COLOR,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 5.w,
          ),
          InkWell(
              onTap: () {
                Get.back();
              },
              child:  Icon(
                showBackButton == true ? Icons.arrow_back : null,
                color: Colors.white,
              )),
          SizedBox(
            width: buttonWidth,
          ),
          AppText(
            text: title ?? 'Branding',
            fontSize: AppDimensions.FONT_SIZE_27,
            color: Constants.WHITE_COLOR,
            fontWeight: FontWeights.medium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              imgPath ?? AppImages.NEW_BRANDING_ICON,
              height: height ?? 38,
              width: width ?? 38,
              color: color ?? Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
