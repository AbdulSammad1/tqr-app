import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/signedScheme/model/signed_model.dart';

import '../../main.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_button.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/signed_controller.dart';

class SignedSchScreen extends StatefulWidget {
  static const routeName = '/signed-sch-screen';

  const SignedSchScreen({Key? key}) : super(key: key);

  @override
  State<SignedSchScreen> createState() => _SignedSchScreenState();
}

class _SignedSchScreenState extends State<SignedSchScreen> {

   var SignedRequestController = Get.put(SignedSchController());
   var signedSchController = Get.find<SignedSchController>();
    TextEditingController searchController = TextEditingController();
    List<SignedSchemeModel> filteredData = [];


   @override
  void initState() {
    super.initState();
    filteredData = signedSchController.signedModelList;
  }

  void filterData(String query) {
    setState(() {
      filteredData = signedSchController.signedModelList.where((item) {
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
                      text: 'In Process',
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
                                                horizontal: 15.w, vertical: 8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: AppText(
                                                    text: 'Edit',
                                                    fontSize: AppDimensions
                                                        .FONT_SIZE_13,
                                                    fontWeight:
                                                        FontWeights.bold,
                                                    color:
                                                        Constants.BLACK_COLOR,
                                                  ),
                                                ),
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
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           right: 12.0),
                                                //   child: AppText(
                                                //     text: 'Status',
                                                //     fontSize: AppDimensions
                                                //         .FONT_SIZE_12,
                                                //     fontWeight:
                                                //         FontWeights.bold,
                                                //     color:
                                                //         Constants.BLACK_COLOR,
                                                //   ),
                                                // ),
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
                                                controller: signedSchController
                                                    .scrollController,
                                                thumbVisibility: true,
                                                radius:
                                                    const Radius.circular(5),
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
                                                        itemBuilder: (context,
                                                            int index) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    signedSchController
                                                                        .signedEditModelList
                                                                        .clear();
                                                                    signedSchController
                                                                        .signedUpdateModelList
                                                                        .clear();
                                                                    signedSchController
                                                                        .customerNameController
                                                                        .value
                                                                        .text = '';
                                                                    signedSchController
                                                                        .schemeNameController
                                                                        .value
                                                                        .text = '';
                                                                    signedSchController
                                                                        .quantityController
                                                                        .value
                                                                        .text = '';
                                                                    signedSchController
                                                                        .amountController
                                                                        .value
                                                                        .text = '';
                                                                    signedSchController
                                                                            .selectedValue
                                                                            ?.value =
                                                                        'Update Status';
                                                                    Future
                                                                        .wait([
                                                                      signedSchController.getSignedUpdateData(signedSchController
                                                                          .signedModelList[
                                                                              index]
                                                                          .transactionId)
                                                                    ]);
                                                                    signedSchController
                                                                        .getSignedEditData(signedSchController
                                                                            .signedModelList[
                                                                                index]
                                                                            .transactionId)
                                                                        .then(
                                                                            (value) {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                IconButton(
                                                                                  icon: const Icon(
                                                                                    Icons.close,
                                                                                    size: 30,
                                                                                  ),
                                                                                  padding: const EdgeInsets.all(0),
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                            scrollable:
                                                                                true,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            contentPadding:
                                                                                const EdgeInsets.symmetric(horizontal: 0),
                                                                            clipBehavior:
                                                                                Clip.antiAliasWithSaveLayer,
                                                                            titlePadding:
                                                                                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                                                            content:
                                                                                Container(
                                                                              height: 600,
                                                                              width: 340.w,
                                                                              alignment: Alignment.center,
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    width: double.infinity,
                                                                                    height: 40.h,
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
                                                                                    child: AppText(
                                                                                      text: 'Update',
                                                                                      fontSize: AppDimensions.FONT_SIZE_24,
                                                                                      fontWeight: FontWeights.semiBold,
                                                                                      color: Constants.WHITE_COLOR,
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Obx(() {
                                                                                      return Padding(
                                                                                        padding: const EdgeInsets.all(15.0),
                                                                                        child: signedSchController.signedEditModelList.isEmpty == true
                                                                                            ? Center(
                                                                                                child: CircularProgressIndicator(
                                                                                                  color: Constants.PRIMARY_COLOR,
                                                                                                ),
                                                                                              )
                                                                                            : Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                          margin: const EdgeInsets.only(bottom: 5),
                                                                                                          child: const Text(
                                                                                                            'Customer Name',
                                                                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                          )),
                                                                                                      Container(
                                                                                                        width: double.infinity,
                                                                                                        padding: const EdgeInsets.all(13),
                                                                                                        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                                                                                                        child: Text(
                                                                                                          '${signedSchController.signedEditModelList[0].customerName}',
                                                                                                          style: const TextStyle(color: Colors.black),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                          margin: const EdgeInsets.only(bottom: 5),
                                                                                                          child: const Text(
                                                                                                            'Scheme Name',
                                                                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                          )),
                                                                                                      Container(
                                                                                                        width: double.infinity,
                                                                                                        padding: const EdgeInsets.all(13),
                                                                                                        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                                                                                                        child: Text(
                                                                                                          '${signedSchController.signedEditModelList[0].schemeName}',
                                                                                                          style: const TextStyle(color: Colors.black),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                          margin: const EdgeInsets.only(bottom: 5),
                                                                                                          child: const Text(
                                                                                                            'Quantity',
                                                                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                          )),
                                                                                                      Container(
                                                                                                        width: double.infinity,
                                                                                                        padding: const EdgeInsets.all(13),
                                                                                                        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                                                                                                        child: Text(
                                                                                                          '${signedSchController.signedEditModelList[0].quantity}',
                                                                                                          style: const TextStyle(color: Colors.black),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),

                                                                                                  Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                          margin: const EdgeInsets.only(bottom: 5),
                                                                                                          child: const Text(
                                                                                                            'Total Scheme Amount',
                                                                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                          )),
                                                                                                      Container(
                                                                                                        width: double.infinity,
                                                                                                        padding: const EdgeInsets.all(13),
                                                                                                        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                                                                                                        child: Text(
                                                                                                          '${signedSchController.signedEditModelList[0].totalSchemeAmount}',
                                                                                                          style: const TextStyle(color: Colors.black),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                          margin: const EdgeInsets.only(bottom: 5),
                                                                                                          child: const Text(
                                                                                                            'Status',
                                                                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                          )),
                                                                                                      Container(
                                                                                                        width: double.infinity,
                                                                                                        padding: const EdgeInsets.all(13),
                                                                                                        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                                                                                                        child: Text(
                                                                                                          '${signedSchController.signedUpdateModelList[0].schemeStatus}',
                                                                                                          style: const TextStyle(color: Colors.black),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  
                                                                                                  signedSchController.isSave.isTrue
                                                                                                      ? Center(
                                                                                                          child: CircularProgressIndicator(
                                                                                                            color: Constants.PRIMARY_COLOR,
                                                                                                          ),
                                                                                                        )
                                                                                                      : AppButton(
                                                                                                          width: double.infinity,
                                                                                                          btnText: 'Update',
                                                                                                          color: Constants.SECONDRY_COLOR,
                                                                                                          onPressed: () {
                                                                                                            signedSchController.saveSignedData(
                                                                                                              signedSchController.signedUpdateModelList[0].schemeStatus,
                                                                                                              signedSchController.signedModelList[index].transactionId,
                                                                                                              
                                                                                                            );
                                                                                                            Get.back();
                                                                                                          },
                                                                                                          height: 30.h,
                                                                                                        ),
                                                                                                ],
                                                                                              ),
                                                                                      );
                                                                                    }),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    });
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right: 10
                                                                            .w),
                                                                    child: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: Constants
                                                                          .PRIMARY_COLOR,
                                                                    ),
                                                                    
                                                                  )),
                                                              Expanded(
                                                                child: AppText(
                                                                  text:
                                                                      '    ${filteredData[index].transDate}',
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
                                                              Expanded(
                                                                child: AppText(
                                                                  text:
                                                                      '${filteredData[index].shopName}',
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
                                                              AppText(
                                                                text:
                                                                    '${filteredData[index].quantity}',
                                                                color: Constants
                                                                    .BLACK_COLOR,
                                                                fontSize:
                                                                    AppDimensions
                                                                        .FONT_SIZE_12,
                                                                fontWeight:
                                                                    FontWeights
                                                                        .medium,
                                                                softWrap: true,
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              // Container(
                                                              //   padding: EdgeInsets
                                                              //       .only(
                                                              //           left:
                                                              //               18),
                                                              //   width: 65.w,
                                                              //   child: AppText(
                                                              //     text:
                                                              //         '${filteredData[index].status}',
                                                              //     color: Constants
                                                              //         .BLACK_COLOR,
                                                              //     fontSize:
                                                              //         AppDimensions
                                                              //             .FONT_SIZE_11,
                                                              //     fontWeight:
                                                              //         FontWeights
                                                              //             .medium,
                                                              //     softWrap:
                                                              //         true,
                                                              //   ),
                                                              // ),
                                                            ],
                                                          );
                                                        }
                                                        )
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
