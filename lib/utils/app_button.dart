import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Fonts/AppDimensions.dart';
import 'Fonts/font_weights.dart';
import 'app_text.dart';
import 'constants.dart';

class AppButton extends StatelessWidget {
  final String btnText;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  const AppButton({Key? key,required this.btnText,this.onPressed,this.height,this.width,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width??250.w,
      height: height??35.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color??Constants.SECONDRY_COLOR),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        child: AppText(
          text: btnText.tr,
          fontSize: AppDimensions.FONT_SIZE_18,
          fontWeight: FontWeights.regular,
          color: Constants.WHITE_COLOR,
        ),
      ),
    );
  }
}
