import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_text.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';

import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_button.dart';

class ExceptionWidget extends StatefulWidget {
  final String? message;
  final VoidCallback? onPressed;
  final bool loading;

  const ExceptionWidget(
      {Key? key, this.message, this.onPressed, this.loading = false})
      : super(key: key);

  @override
  State<ExceptionWidget> createState() => _ExceptionWidgetState();
}

class _ExceptionWidgetState extends State<ExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: height * .15,
          ),
          Icon(
            Icons.cloud_off,
            color: Constants.SECONDRY_COLOR,
            size: 50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            child: Center(
              child: AppText(
                text: widget.message ?? 'No Internet Connection',
                color: Constants.SECONDRY_COLOR,
                fontWeight: FontWeights.bold,
                fontSize: AppDimensions.FONT_SIZE_20,
              ),
            ),
          ),
          SizedBox(
            height: height * .15,
          ),
          widget.loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Constants.PRIMARY_COLOR,
                  ),
                )
              : AppButton(btnText: 'Retry', onPressed: widget.onPressed),
        ],
      ),
    );
  }
}
