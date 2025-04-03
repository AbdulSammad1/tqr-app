import 'package:flutter/material.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';

class InputField2 extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController controller;
  final bool readOnly;
  const InputField2({Key? key,required this.title, required this.controller,this.hintText,this.readOnly=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: AppText(
            text: title,
            color: Constants.BLACK_COLOR,
            fontSize: AppDimensions.FONT_SIZE_14,
            fontWeight: FontWeights.bold,
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 40,
            child: TextFormField(
              controller: controller,
              style: TextStyle(
                color: Constants.BLACK_COLOR,
                fontSize: AppDimensions.FONT_SIZE_14,
              ),
              readOnly: readOnly,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Constants.DARK_GREY_COLOR,
                  fontSize: AppDimensions.FONT_SIZE_12,
                ),
                contentPadding: const EdgeInsets.only(bottom: 5,left: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
