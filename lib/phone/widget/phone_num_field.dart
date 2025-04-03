import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';

class PhoneNumField extends StatelessWidget {
  final TextEditingController? controller;
  final String? helperText,hintText;
  final Function(String)? onChanged;
  final int? maxLength;
  final bool autoFocus;
  const PhoneNumField({Key? key,this.controller,this.helperText,this.onChanged,this.hintText,this.maxLength,this.autoFocus=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 38.w,left: 38.w),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Constants.BLACK_COLOR,
          fontSize: AppDimensions.FONT_SIZE_21,
        ),
        maxLength: maxLength??10,
        textAlign:context.locale.toString() == 'ur'? TextAlign.start : TextAlign.start,
        onChanged: onChanged,
        autofocus: autoFocus,
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
       // textAlign: TextAlign.start,
        decoration: InputDecoration(
          hintText:hintText,
          hintStyle: TextStyle(
            color: Constants.GREY_COLOR,
            fontSize: AppDimensions.FONT_SIZE_18,
          ),
          helperText: helperText,
          contentPadding: const EdgeInsets.all(0),

          prefix: Text(
            '(+92)',
            style: TextStyle(
              color: Constants.BLACK_COLOR,
              fontSize: AppDimensions.FONT_SIZE_21,
            ),
          ),
          enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Constants.GREY_COLOR),
          ),
          focusedBorder:  UnderlineInputBorder(
            borderSide: BorderSide(
                color: Constants.GREY_COLOR),
          ),
        ),
      ),
    );
  }
}


class NotUserWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const NotUserWidget({Key? key,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 5.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
             AppText(
              text: 'Not a user?',
              fontSize: AppDimensions.FONT_SIZE_17,
              fontWeight: FontWeights.medium,
            ),
            SizedBox(
              width: 2.w,
            ),
            AppText(
              text: 'Register Now',
              fontSize: AppDimensions.FONT_SIZE_17,
              fontWeight: FontWeights.medium,
              color: Constants.SECONDRY_COLOR,
            ),
          ],
        ),
      ),
    );
  }
}
