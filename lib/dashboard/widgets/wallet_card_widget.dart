import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_images.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_text.dart';

import '../../main.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/constants.dart';

class NewWalletCard extends StatelessWidget {
  final String? pointsTxt;
  final VoidCallback? onTapRefresh,
      onTapLedger,
      onTapGetPoints,
      onTapTransferPoints;

  const NewWalletCard(
      {super.key,
      this.pointsTxt,
      this.onTapGetPoints,
      this.onTapLedger,
      this.onTapRefresh,
      this.onTapTransferPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170.h,
      decoration: BoxDecoration(
        color: Constants.PRIMARY_COLOR,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.w, bottom: 10.w),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 0,
          color: Constants.WHITE_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Container(
                    width: 180.w,
                    height: 35.w,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 25.h,
                          ),
                          child: Image.asset(
                            AppImages.NEW_WALLET_ICON,
                            height: 34.w,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right:
                                  context.locale.toString() == 'ur' ? 14.w : 0),
                          child: AppText(
                            text: 'My Wallet',
                            fontSize: AppDimensions.FONT_SIZE_25,
                            fontWeight: FontWeights.bold,
                            color: Constants.PRIMARY_COLOR,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    context.locale.toString() == 'ur'
                        ? AppText(
                            text: '$pointsTxt :',
                            fontSize: AppDimensions.FONT_SIZE_28,
                            fontWeight: FontWeights.bold,
                            color: Constants.BLACK_COLOR,
                            overflow: TextOverflow.ellipsis,
                          )
                        : const SizedBox.shrink(),
                    AppText(
                      text: 'Points',
                      fontSize: AppDimensions.FONT_SIZE_29,
                      fontWeight: FontWeights.bold,
                      color: Constants.BLACK_COLOR,
                    ),
                    context.locale.toString() == 'ur'
                        ? const SizedBox.shrink()
                        : AppText(
                            text: ': $pointsTxt',
                            fontSize: AppDimensions.FONT_SIZE_29,
                            fontWeight: FontWeights.bold,
                            color: Constants.BLACK_COLOR,
                            overflow: TextOverflow.ellipsis,
                          ),
                    InkWell(
                      onTap: onTapRefresh,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Image.asset(
                          AppImages.NEW_REFRESH_ICON,
                          height: 25.w,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      box.read('isDistributorLogin') == true
                          ? ElevatedButton(
                              onPressed: onTapTransferPoints,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.SECONDRY_COLOR,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Container(
                                width: 122.w,
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.GET_POINTS_ICON,
                                      height: 18.w,
                                      color: Constants.WHITE_COLOR,
                                    ),
                                    AppText(
                                      text: ' Transfer Points',
                                      fontSize: AppDimensions.FONT_SIZE_13,
                                      fontWeight: FontWeights.bold,
                                      color: Constants.WHITE_COLOR,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: onTapGetPoints,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.SECONDRY_COLOR,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Container(
                                width: 115.w,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      AppImages.GET_POINTS_ICON,
                                      height: 19.h,
                                      color: Constants.WHITE_COLOR,
                                    ),
                                    AppText(
                                      text: 'Get Points',
                                      fontSize:
                                          context.locale.toString() == 'ur'
                                              ? AppDimensions.FONT_SIZE_15
                                              : AppDimensions.FONT_SIZE_15,
                                      fontWeight: FontWeights.bold,
                                      color: Constants.WHITE_COLOR,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      ElevatedButton(
                        onPressed: onTapLedger,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Container(
                          width: 115.w,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20.w),
                                child: Image.asset(
                                  AppImages.LEDGER_ICON,
                                  height: 18.w,
                                  color: Constants.WHITE_COLOR,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: context.locale.toString() == 'ur'
                                        ? 15.w
                                        : 15.w),
                                child: AppText(
                                  text: 'Ledger',
                                  fontSize: AppDimensions.FONT_SIZE_15,
                                  fontWeight: FontWeights.bold,
                                  color: Constants.WHITE_COLOR,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
