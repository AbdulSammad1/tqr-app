import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_images.dart';

import 'Fonts/AppDimensions.dart';
import 'Fonts/font_weights.dart';
import 'app_text.dart';
import 'constants.dart';

class DashboardBottomCard2 extends StatelessWidget {
  final String? subTitle, imagePath, title;
  final VoidCallback? onTap;
  final bool isTitle;
  final bool isSubTitle;
  final Widget? widget;
  final double? imgHeight, cardWidth, cardHeight, imgPadding;

  const DashboardBottomCard2(
      {super.key,
      this.subTitle,
      this.imagePath,
      this.onTap,
      this.isTitle = false,
      this.title,
      this.isSubTitle = true,
      this.imgHeight,
      this.cardHeight,
        this.imgPadding,
        this.widget,
      this.cardWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: isTitle,
          child: AppText(
            text: title ?? 'Scheme',
            fontSize: AppDimensions.FONT_SIZE_21,
            color: Constants.BLACK_COLOR,
            fontWeight: FontWeights.semiBold,
            textAlign: TextAlign.center,
          ),
        ),
        Visibility(
          visible: isTitle,
          child: SizedBox(
            height: 4.w,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: cardHeight ?? 91.w,
            width: cardWidth ?? 90.w,
            child: Card(
              color: Constants.WHITE_COLOR,
              elevation: 5,
              surfaceTintColor: Constants.GREY_COLOR1,
              child: Padding(
                padding: EdgeInsets.only(right: imgHeight ?? 10),
                child: Padding(
                  padding:  EdgeInsets.only(left: imgPadding??0),
                  child: Image.asset(
                    imagePath ?? AppImages.HAND_SPEAKER,
                    height: imgHeight ?? 120,
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isSubTitle,
          child: SizedBox(
            height: 4.w,
          ),
        ),
        Visibility(
          visible: isSubTitle,
          child: AppText(
            text: subTitle ?? 'Scheme',
            fontSize: AppDimensions.FONT_SIZE_15,
            color: Constants.BLACK_COLOR,
            fontWeight: FontWeights.bold,
            textAlign: TextAlign.center,
          ),
        ),
       Column(
         children: [
           widget ?? const SizedBox.shrink(),
         ],
       )
      ],
    );
  }
}

class NewDashBottomCard extends StatelessWidget {
  final String?  title,imPath;
  final VoidCallback? onTap;
  const NewDashBottomCard({super.key,this.title,this.onTap,this.imPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 91.w,
      width:  90.w,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Constants.WHITE_COLOR,
          elevation: 5,
          surfaceTintColor: Constants.GREY_COLOR1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.w),
                child: Image.asset(imPath??AppImages.NEW_SCHEME_ICON,height: 40.h,width: 40.h,),
              ),
              Padding(
                padding:  EdgeInsets.only(bottom: 3.w),
                child: AppText(
                  text: title ?? 'Scheme',
                  fontSize: AppDimensions.FONT_SIZE_14,
                  color: Constants.BLACK_COLOR,
                  fontWeight: FontWeights.bold,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
