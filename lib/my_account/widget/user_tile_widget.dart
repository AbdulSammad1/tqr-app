import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';

class UserTileWidget extends StatelessWidget {
  final String? customerName,
      customerCategory,
      customerArea,
      customerCity,
      customerRegion;

  const UserTileWidget(
      {Key? key,
      this.customerName,
      this.customerCategory,
      this.customerArea,
      this.customerCity,
      this.customerRegion,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.person_rounded,
                size: 35.w,
                color: Constants.PRIMARY_COLOR,
              ),
              title: AppText(
                text: 'Customer Name',
                color: Constants.DARK_GREY_COLOR.withOpacity(0.5),
                fontSize: AppDimensions.FONT_SIZE_16,
                fontWeight: FontWeights.bold,
              ),
              subtitle: AppText(
                text: customerName ?? 'Customer Name',
                color: Constants.BLACK_COLOR,
                fontSize: AppDimensions.FONT_SIZE_14,
                fontWeight: FontWeights.bold,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Divider(
                color: Constants.DARK_GREY_COLOR,
                thickness: 1,
              ),
            ),
          ],
        ),
        Column(
          children: [
            ListTile(
              leading: Icon(
                 Icons.settings,
                size: 35.w,
                color: Constants.PRIMARY_COLOR,
              ),
              title: AppText(
                text: 'Category',
                color: Constants.DARK_GREY_COLOR.withOpacity(0.5),
                fontSize: AppDimensions.FONT_SIZE_16,
                fontWeight: FontWeights.bold,
              ),
              subtitle: AppText(
                text: customerCategory ?? 'Category',
                color: Constants.BLACK_COLOR,
                fontSize: AppDimensions.FONT_SIZE_14,
                fontWeight: FontWeights.bold,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Divider(
                color: Constants.DARK_GREY_COLOR,
                thickness: 1,
              ),
            ),
          ],
        ),
        Column(
          children: [
            ListTile(
              leading: Icon(
                 Icons.area_chart,
                size: 35.w,
                color: Constants.PRIMARY_COLOR,
              ),
              title: AppText(
                text: 'Area',
                color: Constants.DARK_GREY_COLOR.withOpacity(0.5),
                fontSize: AppDimensions.FONT_SIZE_16,
                fontWeight: FontWeights.bold,
              ),
              subtitle: AppText(
                text: customerArea ?? 'Area',
                color: Constants.BLACK_COLOR,
                fontSize: AppDimensions.FONT_SIZE_14,
                fontWeight: FontWeights.bold,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Divider(
                color: Constants.DARK_GREY_COLOR,
                thickness: 1,
              ),
            ),
          ],
        ),
        Column  (
          children: [
            ListTile(
              leading: Icon(
                Icons.location_city,
                size: 35.w,
                color: Constants.PRIMARY_COLOR,
              ),
              title: AppText(
                text: 'City',
                color: Constants.DARK_GREY_COLOR.withOpacity(0.5),
                fontSize: AppDimensions.FONT_SIZE_16,
                fontWeight: FontWeights.bold,
              ),
              subtitle: AppText(
                text: customerCity ?? 'City',
                color: Constants.BLACK_COLOR,
                fontSize: AppDimensions.FONT_SIZE_14,
                fontWeight: FontWeights.bold,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Divider(
                color: Constants.DARK_GREY_COLOR,
                thickness: 1,
              ),
            ),
          ],
        ),
        Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.flag,
                size: 35.w,
                color: Constants.PRIMARY_COLOR,
              ),
              title: AppText(
                text: 'Region',
                color: Constants.DARK_GREY_COLOR.withOpacity(0.5),
                fontSize: AppDimensions.FONT_SIZE_16,
                fontWeight: FontWeights.bold,
              ),
              subtitle: AppText(
                text: customerRegion ?? 'Region',
                color: Constants.BLACK_COLOR,
                fontSize: AppDimensions.FONT_SIZE_14,
                fontWeight: FontWeights.bold,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Divider(
                color: Constants.DARK_GREY_COLOR,
                thickness: 1,
              ),
            ),
          ],
        ),

      ],
    );
  }
}
