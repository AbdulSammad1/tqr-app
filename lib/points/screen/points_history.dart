import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/points/model/points_history_model.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';

import '../../main.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../controller/points_card_controller.dart';

class PointsHistory extends StatefulWidget {
  const PointsHistory({Key? key}) : super(key: key);

  @override
  State<PointsHistory> createState() => _PointsHistoryState();
}

class _PointsHistoryState extends State<PointsHistory> {
  var pointsCardController = Get.put(PointsCardController());

    TextEditingController searchController = TextEditingController();
  List<PointHistoryModel> filteredData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    pointsCardController.refreshDataHistoryPoints();
    filteredData = pointsCardController.pointsHistoryModel;
  }

  void filterData(String query) {
    setState(() {
      filteredData = pointsCardController.pointsHistoryModel.where((item) {
        final date = item.requestDate?.toLowerCase();
        final shopName = item.requestbyName?.toLowerCase();
        final requestNo = item.requestbyNo.toString().toLowerCase();
        final requestPoints = item.requestedPoint.toString().toLowerCase();
        final searchLower = query.toLowerCase();

        // Check if any of the fields contains the search query
        return date!.contains(searchLower) ||
            shopName!.contains(searchLower) ||
            requestNo.contains(searchLower) ||
            requestPoints.contains(searchLower);
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50.h,
              margin: EdgeInsets.only(top: 20.h),
              decoration: BoxDecoration(
                color: Constants.PRIMARY_COLOR.withOpacity(0.8),
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
              child: Row(
                children: [
                    SizedBox(width:5.w,),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white,)),
                    SizedBox(width:120.w,),
                  AppText(
                    text: 'History',
                    fontSize: AppDimensions.FONT_SIZE_24,
                    fontWeight: FontWeights.semiBold,
                    color: Constants.WHITE_COLOR,
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 18.h, left: 10, right: 10),
                padding: const EdgeInsets.only(left: 10),
                height: 35.h,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  controller: searchController,
                  onChanged: (query) {
                    filterData(query);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Constants.PRIMARY_COLOR,
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            Expanded(
              child: Directionality(
                textDirection: directionLtr,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.w, right: 16.w),
                      child: const SizedBox.shrink(),
                    ),
                    Expanded(
                      child: Container(
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
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: AppText(
                                                  text: 'ReqDate',
                                                  fontSize: AppDimensions
                                                      .FONT_SIZE_14,
                                                  fontWeight:
                                                  FontWeights.bold,
                                                  color:
                                                  Constants.BLACK_COLOR,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: AppText(
                                                  text: 'ReqByNo',
                                                  fontSize: AppDimensions
                                                      .FONT_SIZE_14,
                                                  fontWeight:
                                                  FontWeights.bold,
                                                  color:
                                                  Constants.BLACK_COLOR,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: AppText(
                                                  text: 'ReqByName',
                                                  fontSize: AppDimensions
                                                      .FONT_SIZE_14,
                                                  fontWeight:
                                                  FontWeights.bold,
                                                  color:
                                                  Constants.BLACK_COLOR,
                                                ),
                                              ),
                                              AppText(
                                                text: '  ReqPoints',
                                                fontSize: AppDimensions
                                                    .FONT_SIZE_14,
                                                fontWeight: FontWeights.bold,
                                                color: Constants.BLACK_COLOR,
                                              ),
                                            ],
                                          ),
                                        ),
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
                                  Expanded(
                                    child: Obx(() {
                                      return pointsCardController
                                                .isLoading.isTrue
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color:
                                                      Constants.PRIMARY_COLOR,
                                                ),
                                              )
                                            : filteredData.isEmpty
                                                ? Center(
                                                    child: AppText(
                                                      text: 'No Data Found',
                                                      color:
                                                          Constants.BLACK_COLOR,
                                                    ),
                                                  )
                                          : Scrollbar(
                                        controller: pointsCardController
                                            .scrollController,
                                        thumbVisibility: true,
                                        radius:
                                        const Radius.circular(5),
                                        thickness: 5,
                                        child: ListView(
                                          controller:
                                          pointsCardController
                                              .scrollController,
                                          children: [
                                            ListView.builder(
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    0.w),
                                                shrinkWrap: true,
                                                itemExtent: 40.h,
                                                physics:
                                                const BouncingScrollPhysics(),
                                                itemCount:
                                               filteredData
                                                    .length,
                                                itemBuilder: (context,
                                                    int index) {
                                                  return  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                         SizedBox(
                                                        width: 70.w,
                                                        child: Text('${filteredData[index]
                                                            .requestDate}', style: TextStyle(color: Constants
                                                            .BLACK_COLOR,
                                                        fontSize:
                                                        AppDimensions
                                                            .FONT_SIZE_11, fontWeight: FontWeight.bold),),),
                                                        // AppText(
                                                        //   text:
                                                        //   '${pointsCardController
                                                        //       .pointsHistoryModel[index]
                                                        //       .requestDate}   ',
                                                        //   color: Constants
                                                        //       .BLACK_COLOR,
                                                        //   fontSize:
                                                        //   AppDimensions
                                                        //       .FONT_SIZE_13,
                                                        //   fontWeight:
                                                        //   FontWeights
                                                        //       .medium,
                                                        //   softWrap:
                                                        //   true,
                                                        // ),
                                                         SizedBox(
                                                        width: 83.w,
                                                        child: Text('${filteredData[index]
                                                            .requestbyNo}', style: TextStyle(color: Constants
                                                            .BLACK_COLOR,
                                                        fontSize:
                                                        AppDimensions
                                                            .FONT_SIZE_11, fontWeight: FontWeight.bold),),),
                                                        // Expanded(
                                                        //   child: AppText(
                                                        //     text:
                                                        //     '${pointsCardController
                                                        //         .pointsHistoryModel[index]
                                                        //         .requestbyNo}',
                                                        //     color: Constants
                                                        //         .BLACK_COLOR,
                                                        //     fontSize:
                                                        //     AppDimensions
                                                        //         .FONT_SIZE_13,
                                                        //     fontWeight:
                                                        //     FontWeights
                                                        //         .medium,
                                                        //     softWrap:
                                                        //     true,
                                                        //   ),
                                                        // ),
                                                         SizedBox(
                                                        width: 97.w,
                                                        child: Text('${filteredData[index]
                                                            .requestbyName}', style: TextStyle(color: Constants
                                                            .BLACK_COLOR,
                                                        fontSize:
                                                        AppDimensions
                                                            .FONT_SIZE_12, fontWeight: FontWeight.bold),),),
                                                        // Expanded(
                                                        //   child: AppText(
                                                        //     text:
                                                        //     '${pointsCardController
                                                        //         .pointsHistoryModel[index]
                                                        //         .requestbyName}',
                                                        //     color: Constants
                                                        //         .BLACK_COLOR,
                                                        //     fontSize:
                                                        //     AppDimensions
                                                        //         .FONT_SIZE_13,
                                                        //     fontWeight:
                                                        //     FontWeights
                                                        //         .medium,
                                                        //     softWrap:
                                                        //     true,
                                                        //   ),
                                                        // ),
                                                         Container(
                                                        padding: const EdgeInsets.only(right: 10),
                                                        alignment: Alignment.centerRight,
                                                        width: 54.w,
                                                        child: Text('${filteredData[index]
                                                            .requestedPoint}', style: TextStyle(color: Constants
                                                            .BLACK_COLOR,
                                                        fontSize:
                                                        AppDimensions
                                                            .FONT_SIZE_11, fontWeight: FontWeight.bold),),),
                                                        // Padding(
                                                        //   padding: EdgeInsets
                                                        //       .only(
                                                        //       right: 10
                                                        //           .w),
                                                        //   child: AppText(
                                                        //     text:
                                                        //     '${pointsCardController
                                                        //         .pointsHistoryModel[index]
                                                        //         .requestedPoint}',
                                                        //     color: Constants
                                                        //         .BLACK_COLOR,
                                                        //     fontSize:
                                                        //     AppDimensions
                                                        //         .FONT_SIZE_13,
                                                        //     fontWeight:
                                                        //     FontWeights
                                                        //         .medium,
                                                        //     softWrap:
                                                        //     true,
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  );
                                                })
                                          ],
                                        ),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppImages.TQR_LOGO,
                height: 110.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
