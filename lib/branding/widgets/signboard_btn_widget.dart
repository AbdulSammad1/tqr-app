import 'package:flutter/material.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';

class SignboardBtnWidget extends StatelessWidget {
  final String? btnText;
  final VoidCallback? onPressed;
  final MaterialStateProperty<Color>? backgroundColor;

  const SignboardBtnWidget({super.key,this.btnText,this.onPressed,this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 100,
      height: 40,
      child:  ElevatedButton(
        onPressed: onPressed??(){},
        style: ButtonStyle(
          backgroundColor:backgroundColor?? MaterialStateProperty.all<Color>(Constants.SECONDRY_COLOR),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
        ),
        child: AppText(
          text:btnText?? 'Upload front\npicture',
          fontSize: AppDimensions.FONT_SIZE_11,
          fontWeight: FontWeights.bold,
          color: Constants.WHITE_COLOR,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
