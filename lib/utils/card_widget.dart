import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';

class CardWidget extends StatelessWidget {
  final String? title, imgPath;
  final VoidCallback? onTap;

  const CardWidget({Key? key, this.title, this.imgPath,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: AppText(
            text: title ?? 'Item List',
            fontSize: AppDimensions.FONT_SIZE_21,
            color: Constants.BLACK_COLOR,
            fontWeight: FontWeights.semiBold,
            textAlign: TextAlign.center,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 90.w,
            width: 90.w,
            child: Card(
              color: Constants.WHITE_COLOR,
              elevation: 5,
              surfaceTintColor: Constants.GREY_COLOR1,
              child: Center(
                child: Image.asset(
                  imgPath ?? AppImages.NEW_ITEM_LIST_ICON,
                  width: 50,
                  height: 90,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}