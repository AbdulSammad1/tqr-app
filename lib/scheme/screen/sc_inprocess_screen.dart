import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/common/custome_appbar.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_images.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';

import '../../main.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_text.dart';
import '../controller/sc_in_proceesscontroller.dart';

class ScInProcessScreen extends StatefulWidget {
  const ScInProcessScreen({Key? key}) : super(key: key);

  @override
  State<ScInProcessScreen> createState() => _ScInProcessScreenState();
}

class _ScInProcessScreenState extends State<ScInProcessScreen> {
  var inProgressController = Get.find<ScInProcessController>();

  @override
  void initState() {
    inProgressController.getInProgressData();
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
                  imgPath: AppImages.NEW_INPROGRESS_ICON,
                  title: 'In Process',
                  buttonWidth: 70.w,
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
                      padding:  EdgeInsets.symmetric(horizontal: 10.w),
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
                          //   text: 'Status ',
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
                        return inProgressController.inProgressModel.isEmpty==true ? Center(
                          child:inProgressController.isLoading.isTrue? CircularProgressIndicator(color: Constants.PRIMARY_COLOR,) : AppText(text: 'No Data Found',color: Constants.BLACK_COLOR,),
                        ) : Scrollbar(
                          controller: inProgressController.scrollController,
                          thumbVisibility: true,
                          radius: const Radius.circular(5),
                          thickness: 5,
                          child: ListView(
                            controller: inProgressController.scrollController,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemExtent: 40.h,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, int index) {
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10,right: 20.w),
                                        child: AppText(
                                          text: '${inProgressController.inProgressModel[index].date}',
                                          fontSize: AppDimensions.FONT_SIZE_14.sp,
                                          fontWeight: FontWeights.regular,
                                          color: Constants.BLACK_COLOR,
                                        ),
                                      ),
                                      SizedBox(width: 30.w,),
                                      AppText(
                                        text: '${inProgressController.inProgressModel[index].qty}',
                                        fontSize: AppDimensions.FONT_SIZE_14.sp,
                                        fontWeight: FontWeights.regular,
                                        color: Constants.BLACK_COLOR,
                                      ),
                                      SizedBox(width: 40.w,),
                                      Expanded(
                                        child: AppText(
                                          text: '${inProgressController.inProgressModel[index].schemeName}',
                                          fontSize: AppDimensions.FONT_SIZE_14.sp,
                                          fontWeight: FontWeights.regular,
                                          color: Constants.BLACK_COLOR,
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                        ),
                                      ),
                                    
                                      // Expanded(
                                      //   child: AppText(
                                      //     text: '${inProgressController.inProgressModel[index].schemeStatus}',
                                      //     fontSize: AppDimensions.FONT_SIZE_14.sp,
                                      //     fontWeight: FontWeights.regular,
                                      //     color: Constants.BLACK_COLOR,
                                      //     textAlign: TextAlign.left,
                                      //     softWrap: true,
                                      //   ),
                                      // ),
                                    ],
                                  );
                                },
                                itemCount: inProgressController.inProgressModel.length,
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
