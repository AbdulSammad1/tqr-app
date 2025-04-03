import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/constants.dart';

class UpdateTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool readOnly;
  const UpdateTextFieldWidget({Key? key,required this.controller,required this.labelText,this.readOnly=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: Constants.BLACK_COLOR,
          fontSize: AppDimensions.FONT_SIZE_14,
          fontWeight: FontWeights.regular,
        ),
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Constants.BLACK_COLOR,
            fontSize: AppDimensions.FONT_SIZE_14,
            fontWeight: FontWeights.regular,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Constants.PRIMARY_COLOR,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Constants.GREY_COLOR,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
