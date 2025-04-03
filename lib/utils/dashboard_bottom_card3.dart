import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Fonts/AppDimensions.dart';
import 'Fonts/font_weights.dart';
import 'app_images.dart';
import 'app_text.dart';
import 'constants.dart';

class NewDashBottomCard3 extends StatelessWidget {
  final String? title, imPath;
  final VoidCallback? onTap;
  final bool isNew; // Add this boolean to control whether to show the "New" badge
  final String badgetext;
  const NewDashBottomCard3({super.key, this.title, this.onTap, this.imPath, this.isNew = false, required this.badgetext});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 91.w,
      width: 90.w,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Constants.WHITE_COLOR,
          elevation: 5,
          surfaceTintColor: Constants.GREY_COLOR1,
          child: Stack(
            alignment: Alignment.topRight, // Align the badge to the top-right corner
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 4.w),
                    child: Image.asset(imPath ?? AppImages.NEW_SCHEME_ICON, height: 40.h, width: 40.h),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Center(
                      child: AppText(
                        text: title ?? 'Scheme',
                        fontSize: AppDimensions.FONT_SIZE_14,
                        color: Constants.BLACK_COLOR,
                        fontWeight: FontWeights.bold,
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
              if (isNew) // Show the "New" badge only if isNew is true
                Positioned(
                  top: 0,
                  right: 0,
                  child: ClipRRect( // Clip the badge with rounded corners
                    borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                    child: Container(
                      alignment: Alignment.center,
                      // width: 15.w,
                      // height: 15.h,
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      color: Constants.SECONDRY_COLOR, // You can adjust the color of the badge here
                      child: const Text('New', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
