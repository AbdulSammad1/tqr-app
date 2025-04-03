import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_images.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_text.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';

import '../../common/custome_appbar.dart';
import '../../main.dart';
import '../../utils/Fonts/font_weights.dart';
import '../conrtroller/item_list_controller.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemListController = Get.find<ItemListController>();
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: directionLtr,
          child: Column(
            children: [
             CustomAppbar(
                title: 'Item List',
                imgPath: AppImages.NEW_ITEM_LIST_ICON,
                buttonWidth: 80.w,
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
                              text:
                                  'Date : ${itemListController.dateTime.value}',
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
                      height: 280.h,
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
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            child: AppText(
                                              text: 'Item Name',
                                              fontSize:
                                                  AppDimensions.FONT_SIZE_14,
                                              fontWeight: FontWeights.bold,
                                              color: Constants.BLACK_COLOR,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 30, bottom: 5.0, top: 5.0),
                                      child: AppText(
                                        text: 'Min Qty',
                                        fontSize: AppDimensions.FONT_SIZE_14,
                                        fontWeight: FontWeights.bold,
                                        color: Constants.BLACK_COLOR,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0,
                                              right: 30,
                                              bottom: 5.0,
                                              left: 20),
                                          child: AppText(
                                            text: 'Rate',
                                            fontSize:
                                                AppDimensions.FONT_SIZE_14,
                                            fontWeight: FontWeights.bold,
                                            color: Constants.BLACK_COLOR,
                                          ),
                                        ),
                                      ],
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
                                Obx(() {
                                  return Expanded(
                                    child: itemListController
                                            .itemListModel.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: Constants.PRIMARY_COLOR,
                                            ),
                                          )
                                        : Scrollbar(
                                      controller: itemListController
                                          .scrollController,
                                      thumbVisibility: true,
                                      radius: const Radius.circular(5),
                                      thickness: 5,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: itemListController
                                                .itemListModel.length,
                                            controller: itemListController
                                                .scrollController,
                                            itemBuilder:
                                                (context, int index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Padding(
                                                          padding:
                                                           EdgeInsets
                                                              .only(
                                                              left: 30.w),
                                                          child: AppText(
                                                            text:
                                                            '${itemListController.itemListModel[index].itemName}',
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
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: AppText(
                                                          text:
                                                          '${itemListController.itemListModel[index].miniQty}',
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
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                           EdgeInsets
                                                              .only(
                                                              left: 20.w),
                                                          child: AppText(
                                                            text:
                                                            '${itemListController.itemListModel[index].rate}',
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
                                                      )
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
                                          ),
                                        ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
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
                    Text('Note:',style: TextStyle(color: Colors.red, fontSize: AppDimensions.FONT_SIZE_19),),
                    Text('Publicity request submit karne ke time pe Item ki total amount wallet se deduct ki jayegi.', style: TextStyle(color: Colors.black, fontSize: AppDimensions.FONT_SIZE_16),),
                  ],
                ),
              ),
              const SizedBox(height: 90,),
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
