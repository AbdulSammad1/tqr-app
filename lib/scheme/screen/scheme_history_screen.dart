import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/custome_appbar.dart';
import '../../main.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/scheme_histry_controller.dart';

class SchemeHistoryScreen extends StatefulWidget {
  const SchemeHistoryScreen({Key? key}) : super(key: key);

  @override
  State<SchemeHistoryScreen> createState() => _SchemeHistoryScreenState();
}

class _SchemeHistoryScreenState extends State<SchemeHistoryScreen> {
  var historyController = Get.find<SchemeHistoryController>();


  @override
  void initState() {
    historyController.getHistoryData();
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Directionality(
        textDirection: directionLtr,
        child: Column(
          children: [
             CustomAppbar(
              imgPath: AppImages.NEW_HISTORY_ICON,
              title: 'History',
              buttonWidth: 90.w,
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Constants.PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: const EdgeInsets.only(left: 5,right: 5),
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: 'Date',
                        fontSize: AppDimensions.FONT_SIZE_15.sp,
                        fontWeight: FontWeights.semiBold,
                        color: Constants.WHITE_COLOR,
                      ),
                      SizedBox(width: 80.w,),
                      AppText(
                        text: 'Qty',
                        fontSize: AppDimensions.FONT_SIZE_15.sp,
                        fontWeight: FontWeights.semiBold,
                        color: Constants.WHITE_COLOR,
                      ),
                      SizedBox(width: 35.w,),
                      AppText(
                        text: 'Name',
                        fontSize: AppDimensions.FONT_SIZE_15.sp,
                        fontWeight: FontWeights.semiBold,
                        color: Constants.WHITE_COLOR,
                      ),
                      // AppText(
                      //   text: 'Status',
                      //   fontSize: AppDimensions.FONT_SIZE_15.sp,
                      //   fontWeight: FontWeights.semiBold,
                      //   color: Constants.WHITE_COLOR,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
                child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Obx(() {
                return historyController.historyModel.isEmpty  == true
                    ? Center(
                        child: historyController.isLoading.isTrue ? CircularProgressIndicator(
                          color: Constants.PRIMARY_COLOR,
                        ) : AppText(text: 'No Data Found',color: Constants.BLACK_COLOR,),
                      )
                    : Scrollbar(
                        controller: historyController.scrollController,
                        thumbVisibility: true,
                        radius: const Radius.circular(5),
                        thickness: 5,
                        child: ListView(
                          controller: historyController.scrollController,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemExtent: 40.h,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 0),
                              itemBuilder: (context, int index) {
                                return historyController.historyModel[index].date=="" ?Center(
                                  child: AppText(text: 'No Data Found',color: Constants.BLACK_COLOR,),
                                ) : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5,),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 20.w),
                                        child: AppText(
                                          text: '${historyController.historyModel[index].date}',
                                          fontSize: AppDimensions.FONT_SIZE_14.sp,
                                          fontWeight: FontWeights.regular,
                                          color: Constants.BLACK_COLOR,

                                        ),
                                      ),
                                      SizedBox(width: 30.w,),
                                      AppText(
                                        text: '${historyController.historyModel[index].qty}',
                                        fontSize: AppDimensions.FONT_SIZE_14.sp,
                                        fontWeight: FontWeights.regular,
                                        color: Constants.BLACK_COLOR,
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                      ),
                                      Expanded(
                                        child: AppText(
                                          text: '${historyController.historyModel[index].schemeName}',
                                          fontSize: AppDimensions.FONT_SIZE_14.sp,
                                          fontWeight: FontWeights.regular,
                                          color: Constants.BLACK_COLOR,
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 20.w,
                                      // ),
                                      // Expanded(
                                      //   child: AppText(
                                      //     text: historyController.historyModel[index].schemeStatus??'',
                                      //     fontSize: AppDimensions.FONT_SIZE_14.sp,
                                      //     fontWeight: FontWeights.regular,
                                      //     color: Constants.BLACK_COLOR,
                                      //     softWrap: true,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: historyController.historyModel.length,
                            ),
                          ],
                        ),
                      );
              }),
            ))
          ],
        ),
      ),
    ));
  }
}
