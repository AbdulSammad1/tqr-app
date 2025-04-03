import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/font_weights.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../common/input_field.dart';
import '../../login/controller/login_controller.dart';
import '../../poinrequest/controller/point_req_controller.dart';
import '../../utils/app_button.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/transfer_point_controller.dart';

class TransferPointsScreen extends StatefulWidget {
  const TransferPointsScreen({super.key});

  @override
  State<TransferPointsScreen> createState() => _TransferPointsScreenState();
}

class _TransferPointsScreenState extends State<TransferPointsScreen> {
  var loginController = Get.put(LoginController());
  var pointRequestController = Get.find<PointRequestController>();
  final userTypeList = ['Scheme 1', 'Scheme 2', 'Scheme 3'];
  var transferPointController = Get.find<TransferPointsController>();
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;
  var data = Get.arguments;

  @override
  void initState() {
    super.initState();
    if (data == null) {
    } else {
      var num = data[0].toString().substring(2);
      transferPointController.retailerController.text = num;
      transferPointController.pointController.text = '${data[1]}';
      print('data[1] value is ${data[1]}');
      Future.delayed(const Duration(seconds: 1)).then((value) => {
            transferPointController.phoneNumber =
                transferPointController.countryCode +
                    transferPointController.retailerController.text.trim(),
            transferPointController.replaceNum =
                transferPointController.phoneNumber.replaceAll('+', ''),
            transferPointController
                .transferPointApi(transferPointController.replaceNum),
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    SizedBox(width:70.w,),
                    AppText(
                      text: 'Transfer Points',
                      fontSize: AppDimensions.FONT_SIZE_24,
                      fontWeight: FontWeights.semiBold,
                      color: Constants.WHITE_COLOR,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: AppText(
                  text: 'SELECT RETAILER',
                  fontSize: AppDimensions.FONT_SIZE_21,
                  color: Constants.BLACK_COLOR,
                  fontWeight: FontWeights.bold,
                ),
              ),
              Expanded(
                child: Directionality(
                  textDirection: directionLtr,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.w),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                text: '(+92)',
                                color: Constants.BLACK_COLOR,
                                fontSize: AppDimensions.FONT_SIZE_21,
                              ),
                              Expanded(
                                flex: 2,
                                child: InputField(
                                  controller: transferPointController
                                      .retailerController,
                                  isShowTitle: false,
                                  hintText: 'Search from number',
                                  inputFormatter: [
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Obx(() {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: transferPointController.isGet.isTrue
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: Constants.PRIMARY_COLOR,
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () {
                                              transferPointController
                                                      .phoneNumber =
                                                  transferPointController
                                                          .countryCode +
                                                      transferPointController
                                                          .retailerController
                                                          .text
                                                          .trim();
                                              transferPointController
                                                      .replaceNum =
                                                  transferPointController
                                                      .phoneNumber
                                                      .replaceAll('+', '');
                                              transferPointController
                                                  .transferPointApi(
                                                      transferPointController
                                                          .replaceNum);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Constants.PRIMARY_COLOR,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: AppText(
                                              text: 'Get',
                                              fontSize:
                                                  AppDimensions.FONT_SIZE_14,
                                              color: Constants.WHITE_COLOR,
                                              fontWeight: FontWeights.bold,
                                            ),
                                          ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Obx(() {
                            return transferPointController
                                        .transferModelList.isEmpty ==
                                    true
                                ? const SizedBox.shrink()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //shop name
                                      RichText(
                                        softWrap: true,
                                        text: TextSpan(
                                          text: 'Shop name:  ',
                                          style: TextStyle(
                                            color: Constants.BLACK_COLOR,
                                            fontSize:
                                                AppDimensions.FONT_SIZE_18,
                                            fontWeight: FontWeights.semiBold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: transferPointController
                                                  .memberName.value,
                                              style: TextStyle(
                                                color: Constants.PRIMARY_COLOR,
                                                fontSize:
                                                    AppDimensions.FONT_SIZE_16,
                                                fontWeight: FontWeights.medium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //region name
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 10.0.w, top: 10.0.w),
                                        child: RichText(
                                          softWrap: true,
                                          text: TextSpan(
                                            text: 'Region:  ',
                                            style: TextStyle(
                                              color: Constants.BLACK_COLOR,
                                              fontSize:
                                                  AppDimensions.FONT_SIZE_18,
                                              fontWeight: FontWeights.semiBold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: transferPointController
                                                    .memberRegion.value,
                                                style: TextStyle(
                                                  color:
                                                      Constants.PRIMARY_COLOR,
                                                  fontSize: AppDimensions
                                                      .FONT_SIZE_16,
                                                  fontWeight:
                                                      FontWeights.medium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      //city
                                      RichText(
                                        softWrap: true,
                                        text: TextSpan(
                                          text: 'City:  ',
                                          style: TextStyle(
                                            color: Constants.BLACK_COLOR,
                                            fontSize:
                                                AppDimensions.FONT_SIZE_18,
                                            fontWeight: FontWeights.semiBold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: transferPointController
                                                          .transferModelList
                                                          .first
                                                          .city ==
                                                      null
                                                  ? 'N/A'
                                                  : transferPointController
                                                      .memberCity.value,
                                              style: TextStyle(
                                                color: Constants.PRIMARY_COLOR,
                                                fontSize:
                                                    AppDimensions.FONT_SIZE_16,
                                                fontWeight: FontWeights.medium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //area name
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 8.0.w,
                                        ),
                                        child: RichText(
                                          softWrap: true,
                                          text: TextSpan(
                                            text: 'Area:  ',
                                            style: TextStyle(
                                              color: Constants.BLACK_COLOR,
                                              fontSize:
                                                  AppDimensions.FONT_SIZE_18,
                                              fontWeight: FontWeights.semiBold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: transferPointController
                                                    .memberArea.value,
                                                style: TextStyle(
                                                  color:
                                                      Constants.PRIMARY_COLOR,
                                                  fontSize: AppDimensions
                                                      .FONT_SIZE_16,
                                                  fontWeight:
                                                      FontWeights.medium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                          }),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: InputField(
                                controller:
                                    transferPointController.pointController,
                                isShowTitle: true,
                                titleTxt: 'Points',
                                hintText: 'Points',
                                inputFormatter: [
                                  //limit to 6 characters
                                  LengthLimitingTextInputFormatter(9),
                                ],
                                onChanged: (val) {
                                  if (val.isEmpty) {
                                    debugPrint('empty');
                                  } else {
                                    String formatted = transferPointController
                                        .formatter
                                        .format(
                                            int.parse(val.replaceAll(',', '')));
                                    transferPointController.pointController
                                        .value = TextEditingValue(
                                      text: formatted,
                                      selection: TextSelection.collapsed(
                                          offset: formatted.length),
                                    );
                                  }
                                },
                              ),
                            ),
                            Obx(() {
                              return Center(
                                child: transferPointController.isBuy.isTrue
                                    ? CircularProgressIndicator(
                                        color: Constants.PRIMARY_COLOR,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: AppButton(
                                          btnText: 'Transfer',
                                          width: double.infinity,
                                          color: Constants.SECONDRY_COLOR,
                                          onPressed: () async {
                                            var retailerNumber =
                                                '92${transferPointController.retailerController.text.trim()}';
                                            bool isValidRetailer =
                                                await transferPointController
                                                    .checkRetailerNumber(
                                                        retailerNumber);
                                            if (transferPointController
                                                    .pointController
                                                    .text
                                                    .isEmpty ||
                                                int.parse(
                                                        transferPointController
                                                            .pointController
                                                            .text
                                                            .replaceAll(
                                                                ',', '')) <=
                                                    0) {
                                              Utils.appSnackBar(
                                                  subtitle:
                                                      'Valid points are required');
                                            } else if (transferPointController
                                                .retailerController
                                                .text
                                                .isEmpty) {
                                              Utils.appSnackBar(
                                                  subtitle:
                                                      'Retailer number is required');
                                            } else if (transferPointController
                                                .transferModelList.isEmpty) {
                                              Utils.appSnackBar(
                                                  title: 'Alert',
                                                  subtitle:
                                                      'Please get Retailer details first');
                                            } else if (!isValidRetailer) {
                                              Utils.appSnackBar(
                                                  title: 'Alert',
                                                  subtitle:
                                                      'Please Enter correct No.');
                                              transferPointController
                                                  .clearUserData();
                                            } else {
                                              var replaceComma =
                                                  transferPointController
                                                      .pointController.text
                                                      .replaceAll(',', '');
                                              var parsedAmount =
                                                  int.tryParse(replaceComma);
                                              if (parsedAmount == null) {
                                                Utils.appSnackBar(
                                                    subtitle:
                                                        'Invalid point amount');
                                                return;
                                              }

                                              transferPointController
                                                  .isBuy.value = true;
                                              pointRequestController
                                                  .validatePtsMethod()
                                                  .then((value) async {
                                                if (parsedAmount >
                                                    int.parse(
                                                        pointRequestController
                                                            .pts)) {
                                                  transferPointController
                                                      .isBuy.value = false;
                                                  Utils.appSnackBar(
                                                      title: 'Error',
                                                      subtitle:
                                                          'You do not have enough points');
                                                } else {
                                                  transferPointController
                                                      .generateRandomNum();

                                                  var retailerNumber =
                                                      '92${transferPointController.retailerController.text.trim()}';

                                                  var transferCode =
                                                      data != null
                                                          ? data[2]
                                                          : '';

                                                  print('trans code $transferCode');

                                                  bool isSuccessful = false;

                                                  showFunctionDialogBox(
                                                      context,
                                                      'Alert!',
                                                      'Do you want to Transfer Points?',
                                                      () async {
                                                    Get.back();

                                                    isSuccessful =
                                                        await transferPointController
                                                            .transferPtValidateBool(
                                                      parsedAmount.toString(),
                                                      retailerNumber,
                                                      transferCode,
                                                      context,
                                                    );

                                                    // Get.back();
                                                   
                                                  }, () {
                                                    Get.back();
                                                    transferPointController
                                                        .isBuy.value = false;
                                                  });

                                                  //  if (isSuccessful) {
                                                  //     showDialog(
                                                  //       context: context,
                                                  //       builder: (BuildContext
                                                  //           context) {
                                                  //         return SuccessDialog(
                                                  //           receiverName: '',
                                                  //           receiverNo:
                                                  //               retailerNumber,
                                                  //           amount: '',
                                                  //           heading:
                                                  //               'Points transferred',
                                                  //           onTap: () {},
                                                  //         );
                                                  //       },
                                                  //     );
                                                  //   }
                                                  // transferPointController.transferPtValidate(
                                                  //   parsedAmount.toString(),
                                                  //   retailerNumber,
                                                  //   transferCode,
                                                  //   context,
                                                  // );
                                                }
                                              });
                                            }
                                          },
                                        ),
                                      ),
                              );
                            }),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                height: 80.w,
                                child: Image.asset(AppImages.TQR_LOGO),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
