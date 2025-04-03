import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';

class ListTileWidget extends StatelessWidget {
  final String? titleText,subTitleText;
  final Widget? arrowDownWidget;
  const ListTileWidget({Key? key,this.subTitleText,this.titleText,this.arrowDownWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:arrowDownWidget?? Image.asset(
        AppImages.ARROW_UP_ICON,
        height: 30.w,
        width: 30.w,
        color: Constants.GREEN_COLOR,
      ),
      title: AppText(
        text: titleText??'Total Points In',
        fontWeight: FontWeights.bold,
        fontSize:
        AppDimensions.FONT_SIZE_14.sp,
      ),
      subtitle: AppText(
        text:
        '$subTitleText',
        fontWeight: FontWeights.regular,
        fontSize:
        AppDimensions.FONT_SIZE_14,
        color: Constants.BLACK_COLOR
            .withOpacity(0.8),
      ),
    );
  }
}
