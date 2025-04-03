import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import '../utils/Fonts/AppDimensions.dart';
import '../utils/Fonts/font_weights.dart';
import '../utils/app_text.dart';
import '../utils/constants.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? suffixTxt, titleTxt,hintText;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextStyle? textStyle;
  final int? maxlength;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String)? onChanged;
  final EdgeInsets? padding;
  final bool obSecureText;
  final Widget? suffixIcon,prefix;

  const InputField({
    Key? key,
    this.controller,
    this.suffixTxt,
    this.titleTxt,
    this.hintText,
    this.isShowTitle = false,
    this.padding,
    this.keyboardType,
    this.maxLines,
    this.textStyle,
    this.maxlength,
    this.inputFormatter,
    this.onChanged,
    this.obSecureText = false,
    this.suffixIcon,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: directionLtr,
      child: Column(
        crossAxisAlignment:context.locale.toString() == 'ur' ?CrossAxisAlignment.start : CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isShowTitle,
            child: Padding(
              padding: padding?? const EdgeInsets.only(bottom: 10),
              child: AppText(
                text: titleTxt ?? 'Request',
                fontSize: AppDimensions.FONT_SIZE_18,
                fontWeight: FontWeights.semiBold,
                color: Constants.BLACK_COLOR,
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            textAlign: context.locale.toString() == 'ur' ? TextAlign.left : TextAlign.left,
            keyboardType: keyboardType ?? TextInputType.number,
            maxLines: maxLines,
            maxLength: maxlength,
            obscureText: obSecureText,
            inputFormatters: inputFormatter,
            style:textStyle?? TextStyle(
              color: Constants.BLACK_COLOR,
              fontSize: AppDimensions.FONT_SIZE_21,

            ),
            onChanged: onChanged,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.only(top: 11.w,left: 2.w),
              hintText: (hintText??'').tr(),
              hintStyle: TextStyle(
                
                color: Constants.GREY_COLOR,
                fontSize: AppDimensions.FONT_SIZE_18,
              ),
              prefix: prefix,
              suffix:suffixIcon?? AppText(
                text:context.locale.toString() == 'ur' ? '': suffixTxt ?? '',
                fontSize: AppDimensions.FONT_SIZE_18,
                fontWeight: FontWeights.medium,
                color: Constants.BLACK_COLOR,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Constants.GREY_COLOR),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
