import 'dart:ui' as UI;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../poinrequest/controller/point_req_controller.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_loader.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';


class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UI.TextDirection directionLtr = UI.TextDirection.ltr;
    return Scaffold(
        backgroundColor: Constants.WHITE_COLOR,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              Align(
                child: SizedBox(
                  height: 200.h,
                  child: Image.asset(AppImages.TQR_LOGO),
                ),
              ),
              SizedBox(height: 40.h,),
              Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: 5.w, right: 15.w, top: 0.w, bottom: 0.w),
                          child: SizedBox(
                            width: double.infinity,
                            child: Card(
                              elevation: 0,
                              color: Constants.WHITE_COLOR,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(0.w),
                                child: Column(
                                 mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Image.asset(
                                                AppImages.NEW_WALLET_ICON,
                                                height: 45.w,
                                              ),
                                              AppText(
                                                text: 'My Wallet',
                                                fontSize: AppDimensions
                                                    .FONT_SIZE_30,
                                                fontWeight: FontWeights.bold,
                                                color: Constants.PRIMARY_COLOR,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    GetBuilder<PointRequestController>(
                                      assignId: true,
                                      builder: (logic) {
                                        return Directionality(
                                          textDirection: directionLtr,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              context.locale.toString() == 'ur' ?  Row(
                                                children: [
                                                  AppText(
                                                    text: logic.val??0,
                                                    fontSize:
                                                    AppDimensions.FONT_SIZE_30,
                                                    fontWeight: FontWeights.bold,
                                                    color: Constants.BLACK_COLOR,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                  AppText(
                                                    text: ' :پوائنٹس',
                                                    fontSize: AppDimensions
                                                        .FONT_SIZE_28,
                                                    fontWeight: FontWeights.bold,
                                                    color: Constants.BLACK_COLOR,
                                                  ),

                                                ],
                                              ):   Row(
                                                children: [
                                                  AppText(
                                                    text: 'Points: ',
                                                    fontSize: AppDimensions
                                                        .FONT_SIZE_30,
                                                    fontWeight: FontWeights.bold,
                                                    color: Constants.BLACK_COLOR,
                                                  ),
                                                   AppText(
                                                    text:  logic.val??0,
                                                    fontSize:
                                                    AppDimensions.FONT_SIZE_28,
                                                    fontWeight: FontWeights.bold,
                                                    color: Constants.BLACK_COLOR,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ],
                                              ),

                                              InkWell(
                                                onTap: () {
                                                  Future.delayed(
                                                      const Duration(
                                                          microseconds: 550), () {
                                                    appLoader(
                                                        context,
                                                        Constants.PRIMARY_COLOR);
                                                    logic
                                                        .dashBRefreshPointRequest();
                                                  });
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.w),
                                                  child: Image.asset(
                                                    AppImages.NEW_REFRESH_ICON,
                                                    height: 30.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}