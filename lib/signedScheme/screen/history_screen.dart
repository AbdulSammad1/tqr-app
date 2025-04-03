import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/signedScheme/model/history_model.dart';

import '../../main.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/signed_controller.dart';

// Import statements for your other dependencies...

class HistoryScreen extends StatefulWidget {
  static const routeName = '/history-screen';

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var signedSchController = Get.put(SignedSchController());
  TextEditingController searchController = TextEditingController();
  List<SignedHistoryModel> filteredData = [];

  @override
  void initState() {
    super.initState();
    // Initialize your data and assign it to filteredData initially
    filteredData = signedSchController.signedHistoryModelList;
  }

  // Function to filter data based on search query
  void filterData(String query) {
    setState(() {
      filteredData = signedSchController.signedHistoryModelList.where((item) {
        final date = item.transDate?.toLowerCase();
        final shopName = item.shopName?.toLowerCase();
        final qty = item.quantity;
        final status = item.status?.toLowerCase();
        final searchLower = query.toLowerCase();

        // Check if any of the fields contains the search query
        return date!.contains(searchLower) ||
            shopName!.contains(searchLower) ||
            shopName.contains(qty.toString()) ||
            status!.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
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
                    SizedBox(width:100.w,),
                    AppText(
                      text: 'History',
                      fontSize: AppDimensions.FONT_SIZE_24,
                      fontWeight: FontWeights.semiBold,
                      color: Constants.WHITE_COLOR,
                    ),
                  ],
                ),
              ),
              // Add the search bar at the top
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
                                                horizontal: 15.w, vertical: 8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: AppText(
                                                    text: 'Trans Date',
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
                                                    text: 'Shop Name',
                                                    fontSize: AppDimensions
                                                        .FONT_SIZE_14,
                                                    fontWeight:
                                                        FontWeights.bold,
                                                    color:
                                                        Constants.BLACK_COLOR,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: AppText(
                                                    text: 'Qty',
                                                    fontSize: AppDimensions
                                                        .FONT_SIZE_14,
                                                    fontWeight:
                                                        FontWeights.bold,
                                                    color:
                                                        Constants.BLACK_COLOR,
                                                  ),
                                                ),
                                                AppText(
                                                  text: 'Status',
                                                  fontSize: AppDimensions
                                                      .FONT_SIZE_14,
                                                  fontWeight: FontWeights.bold,
                                                  color: Constants.BLACK_COLOR,
                                                ),
                                                SizedBox(
                                                  width: 15.h,
                                                )
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
                                        return signedSchController
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
                                                    controller:
                                                        signedSchController
                                                            .scrollController,
                                                    thumbVisibility: true,
                                                    radius:
                                                        const Radius.circular(
                                                            5),
                                                    thickness: 5,
                                                    child: ListView(
                                                      controller:
                                                          signedSchController
                                                              .scrollController,
                                                      children: [
                                                        ListView.builder(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15.w),
                                                            shrinkWrap: true,
                                                            itemExtent: 40.h,
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            itemCount:
                                                                filteredData
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    int index) {
                                                              return Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        AppText(
                                                                      text:
                                                                          '${filteredData[index].transDate}',
                                                                      color: Constants
                                                                          .BLACK_COLOR,
                                                                      fontSize:
                                                                          AppDimensions
                                                                              .FONT_SIZE_13,
                                                                      fontWeight:
                                                                          FontWeights
                                                                              .medium,
                                                                      softWrap:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        AppText(
                                                                      text:
                                                                          '${filteredData[index].shopName}',
                                                                      color: Constants
                                                                          .BLACK_COLOR,
                                                                      fontSize:
                                                                          AppDimensions
                                                                              .FONT_SIZE_12,
                                                                      fontWeight:
                                                                          FontWeights
                                                                              .medium,
                                                                      softWrap:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 40.w,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right: 12
                                                                            .w),
                                                                    child:
                                                                        AppText(
                                                                      text:
                                                                          '${filteredData[index].quantity}',
                                                                      color: Constants
                                                                          .BLACK_COLOR,
                                                                      fontSize:
                                                                          AppDimensions
                                                                              .FONT_SIZE_13,
                                                                      fontWeight:
                                                                          FontWeights
                                                                              .medium,
                                                                      softWrap:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                20),
                                                                    width: 75.w,
                                                                    child:
                                                                        AppText(
                                                                      text:
                                                                          '${filteredData[index].status}',
                                                                      color: Constants
                                                                          .BLACK_COLOR,
                                                                      fontSize:
                                                                          AppDimensions
                                                                              .FONT_SIZE_11,
                                                                      fontWeight:
                                                                          FontWeights
                                                                              .medium,
                                                                      softWrap:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                ],
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
      ),
    );
  }
}
