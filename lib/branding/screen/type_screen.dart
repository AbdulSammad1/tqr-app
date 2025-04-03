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
import '../controller/type_controller.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var typeController = Get.find<TypeController>();
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: directionLtr,
          child: Column(
            children: [
              CustomAppbar(
                title: 'Type',
                imgPath: AppImages.NEW_ITEM_LIST_ICON,
                buttonWidth: 110.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.w, right: 16.w),
                      child: const SizedBox.shrink(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: AppText(
                              text: 'Date: ${typeController.dateTime.value}',
                              fontSize: AppDimensions.FONT_SIZE_14,
                              fontWeight: FontWeights.medium,
                              color: Constants.GREEN_COLOR,
                            ),
                          );
                        })
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 260.h,
                      decoration: BoxDecoration(
                        border: Border.lerp(
                          Border(
                            top: BorderSide(
                              color: Constants.GREY_COLOR,
                              width: 1,
                            ),
                          ),
                          Border(
                            top: BorderSide(
                              color: Constants.GREY_COLOR,
                              width: 1,
                            ),
                          ),
                          0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5.0,
                                          bottom: 5.0,
                                          left: 15.w,
                                          right: 15.w),
                                      child: AppText(
                                        text: 'Item Name',
                                        fontSize: AppDimensions.FONT_SIZE_14,
                                        fontWeight: FontWeights.bold,
                                        color: Constants.BLACK_COLOR,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 5.0, top: 5.0, right: 15.w),
                                      child: AppText(
                                        text: 'Rate(Per SQ)',
                                        fontSize: AppDimensions.FONT_SIZE_12,
                                        fontWeight: FontWeights.bold,
                                        color: Constants.BLACK_COLOR,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5.0, top: 5.0),
                                      child: AppText(
                                        text: 'Min. Adv',
                                        fontSize: AppDimensions.FONT_SIZE_12,
                                        fontWeight: FontWeights.bold,
                                        color: Constants.BLACK_COLOR,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  height: 5,
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //data here
                                Expanded(
                                  child: Obx(() {
                                    return typeController.bTypeModel.isEmpty ==
                                            true
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: Constants.PRIMARY_COLOR,
                                            ),
                                          )
                                        : Scrollbar(
                                            controller:
                                                typeController.scrollController,
                                            thumbVisibility: true,
                                            radius: const Radius.circular(5),
                                            thickness: 5,
                                            child: ListView.builder(
                                              itemBuilder:
                                                  (context, int index) {
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 15.w,
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: AppText(
                                                            text:
                                                                '${typeController.bTypeModel[index].item}',
                                                            color: Constants
                                                                .BLACK_COLOR,
                                                            fontSize:
                                                                AppDimensions
                                                                    .FONT_SIZE_13,
                                                            fontWeight:
                                                                FontWeights
                                                                    .medium,
                                                            softWrap: true,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Expanded(
                                                          child: AppText(
                                                            text:
                                                                '${typeController.bTypeModel[index].rate}',
                                                            color: Constants
                                                                .BLACK_COLOR,
                                                            fontSize:
                                                                AppDimensions
                                                                    .FONT_SIZE_13,
                                                            fontWeight:
                                                                FontWeights
                                                                    .medium,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 50.w,
                                                        ),
                                                        Expanded(
                                                          child: AppText(
                                                            text:
                                                                '${typeController.bTypeModel[index].minimumAdvance}',
                                                            color: Constants
                                                                .BLACK_COLOR,
                                                            fontSize:
                                                                AppDimensions
                                                                    .FONT_SIZE_13,
                                                            fontWeight:
                                                                FontWeights
                                                                    .medium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: double.infinity,
                                                      child: Divider(
                                                        color: Colors.grey,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              shrinkWrap: true,
                                              controller: typeController
                                                  .scrollController,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: typeController
                                                  .bTypeModel.length,
                                            ),
                                          );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 70.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Note:',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: AppDimensions.FONT_SIZE_19),
                    ),
                    Text(
                      'Branding request ki 30% raqam wallet se deduct ki jayegi jiske liye minimum advance amount hona lazmi hai.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: AppDimensions.FONT_SIZE_16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 90.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  AppImages.TQR_LOGO,
                  height: 90.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
