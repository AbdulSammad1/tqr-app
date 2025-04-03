import 'dart:developer';
import 'dart:ui' as UI;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/main.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_button.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../common/custome_appbar.dart';
import '../../common/input_field2.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../conrtroller/new_request_controller.dart';

class PubNewReqScreen extends StatefulWidget {
  const PubNewReqScreen({Key? key}) : super(key: key);

  @override
  State<PubNewReqScreen> createState() => _PubNewReqScreenState();
}

class _PubNewReqScreenState extends State<PubNewReqScreen> {
  var newReqController = Get.find<NewRequestController>();
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 400), () {
      Future.wait([
        newReqController.getPNewReqData(),
        newReqController.getPNewReqDropDData(context)
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
 CustomAppbar(
              title: 'New Request',
              imgPath: AppImages.NEW_REQUEST_ICON,
              buttonWidth: 70.w,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Directionality(
                  textDirection: directionLtr,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.w, right: 16.w),
                        child: const SizedBox.shrink(),
                      ),
                      //amouunt table
                      Container(
                        width: double.infinity,
                        height: 100.h,
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText(
                                                text: 'Item Name',
                                                fontSize:
                                                    AppDimensions.FONT_SIZE_14,
                                                fontWeight: FontWeights.bold,
                                                color: Constants.BLACK_COLOR,
                                              ),
                                              AppText(
                                                text: '             QTY',
                                                fontSize:
                                                    AppDimensions.FONT_SIZE_14,
                                                fontWeight: FontWeights.bold,
                                                color: Constants.BLACK_COLOR,
                                              ),
                                              AppText(
                                                text: 'Rate',
                                                fontSize:
                                                    AppDimensions.FONT_SIZE_14,
                                                fontWeight: FontWeights.bold,
                                                color: Constants.BLACK_COLOR,
                                              ),
                                              AppText(
                                                text: 'Amount',
                                                fontSize:
                                                    AppDimensions.FONT_SIZE_14,
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
                                  Obx(() {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            //item name dropdown
                                            Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5.w, right: 30),
                                                child: Directionality(
                                                  textDirection: context.locale
                                                      .toString() ==
                                                      'ur'
                                                      ? directionRtr
                                                      : directionLtr,
                                                  child: DropdownButtonFormField2(
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                      ),
                                                    ),
                                                    customButton: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5,
                                                          horizontal: 10),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            context.locale
                                                                        .toString() ==
                                                                    'ur'
                                                                ? const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down,
                                                                    color: Colors
                                                                        .black,
                                                                  )
                                                                : const SizedBox
                                                                    .shrink(),
                                                            context.locale
                                                                        .toString() ==
                                                                    'ur'
                                                                ? const Spacer()
                                                                : const SizedBox
                                                                    .shrink(),
                                                            Flexible(
                                                              fit: FlexFit.loose,
                                                              flex: 10,
                                                              child: AppText(
                                                                text: newReqController
                                                                        .selectedItemName
                                                                        ?.value ??
                                                                    'Item name',
                                                                fontSize:
                                                                    AppDimensions
                                                                        .FONT_SIZE_14,
                                                                fontWeight:
                                                                    FontWeights
                                                                        .medium,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            context.locale
                                                                        .toString() ==
                                                                    'ur'
                                                                ? const SizedBox
                                                                    .shrink()
                                                                : const Spacer(),
                                                            context.locale
                                                                        .toString() ==
                                                                    'ur'
                                                                ? const SizedBox
                                                                    .shrink()
                                                                : const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    isExpanded: true,
                                                    hint: const Text(
                                                      'Item name',
                                                      style:
                                                          TextStyle(fontSize: 14),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    alignment: Alignment.centerLeft,
                                                    items: newReqController
                                                        .pNewReqDropDModel
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  '${item.itemName}',
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: AppText(
                                                                text:
                                                                    '${item.itemName}',
                                                                fontSize:
                                                                    AppDimensions
                                                                        .FONT_SIZE_14,
                                                                fontWeight:
                                                                    FontWeights
                                                                        .regular,
                                                                softWrap: true,
                                                              ),
                                                            ))
                                                        .toList(),
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'Please select scheme.';
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (value) {
                                                      newReqController
                                                              .selectedItemName
                                                              ?.value =
                                                          value.toString();
                                                      newReqController.minQty
                                                          ?.value = newReqController
                                                              .pNewReqDropDModel
                                                              .firstWhere((element) =>
                                                                  element
                                                                      .itemName ==
                                                                  value)
                                                              .miniQty ??
                                                          '';
                                                      newReqController.rate
                                                          .value = newReqController
                                                              .pNewReqDropDModel
                                                              .firstWhere((element) =>
                                                                  element
                                                                      .itemName ==
                                                                  value)
                                                              .rate ??
                                                          '';
                                                      newReqController.qtyController
                                                          .clear();
                                                    },
                                                    onSaved: (value) {
                                                      newReqController
                                                              .selectedItemName
                                                              ?.value =
                                                          value.toString();
                                                    },
                                                    buttonStyleData:
                                                        const ButtonStyleData(
                                                      height: 60,
                                                      padding: EdgeInsets.only(
                                                          left: 20, right: 10)
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons.keyboard_arrow_down,
                                                        color: Colors.black,
                                                      ),
                                                      iconSize: 30,
                                                      iconDisabledColor:
                                                          Colors.transparent,
                                                      iconEnabledColor:
                                                          Colors.transparent,
                                                    ),
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                      ),
                                                         maxHeight: 500.w,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                height: 30.w,
                                                padding: const EdgeInsets.only(
                                                    right: 30),
                                                margin:
                                                    EdgeInsets.only(bottom: 13.w),
                                                child: TextFormField(
                                                  controller: newReqController
                                                      .qtyController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                    fontSize: AppDimensions
                                                        .FONT_SIZE_18,
                                                    fontWeight:
                                                        FontWeights.regular,
                                                    color: Constants.BLACK_COLOR,
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                      color: Constants.GREY_COLOR,
                                                      fontSize: AppDimensions
                                                          .FONT_SIZE_18,
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Constants
                                                              .GREY_COLOR),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Constants
                                                              .PRIMARY_COLOR),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 5.w),
                                                  ),
                                                  onFieldSubmitted: (val) {
                                                    if (newReqController
                                                            .selectedItemName
                                                            ?.value ==
                                                        'Item name') {
                                                      Utils.appSnackBar(
                                                        title: 'Error',
                                                        subtitle:
                                                            'Please select item',
                                                      );
                                                    } else {
                                                      if (int.parse(
                                                              newReqController
                                                                  .qtyController
                                                                  .text
                                                                  .trim()) <
                                                          int.parse(
                                                              newReqController
                                                                      .minQty
                                                                      ?.value ??
                                                                  '0')) {
                                                        Utils.appSnackBar(
                                                          title: 'Error',
                                                          subtitle:
                                                              'Value should be greater than ${newReqController.minQty?.value}',
                                                        );
                                                        log('enter max than ${newReqController.minQty?.value}');
                                                      } else {
                                                        newReqController
                                                            .totalAmountCalculation(
                                                          itemCtrl:
                                                              newReqController
                                                                  .qtyController
                                                                  .text
                                                                  .trim(),
                                                          itemRate:
                                                              newReqController
                                                                  .rate.value,
                                                        );
                                                      }
                                                    }
                                                  },
                                                  onChanged: (val) {
                                                    if (int.tryParse(val) ==
                                                        null) {
                                                      logger.d('value is null');
                                                    } else if(newReqController
                                                        .minQty?.value==''){
                                                      logger.w('min qty is null');
                                                    }
                                                    else if (int.parse(val) <
                                                        int.parse(newReqController
                                                                .minQty?.value ??
                                                            '0')) {
                                                      newReqController.totalAmount
                                                          .value = '0';
                                                      logger.d(
                                                          'value is less than min qty');
                                                    } else {
                                                      newReqController
                                                          .totalAmountCalculation(
                                                        itemCtrl: newReqController
                                                            .qtyController.text
                                                            .trim(),
                                                        itemRate: newReqController
                                                            .rate.value,
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: AppText(
                                                text:
                                                    '  ${newReqController.rate.value}',
                                                color: Constants.BLACK_COLOR,
                                                fontSize:
                                                    AppDimensions.FONT_SIZE_13,
                                                fontWeight: FontWeights.medium,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: AppText(
                                                  text: newReqController
                                                      .totalAmount.value,
                                                  color: Constants.BLACK_COLOR,
                                                  fontSize:
                                                      AppDimensions.FONT_SIZE_13,
                                                  fontWeight: FontWeights.medium,
                                                ),
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
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InputField2(
                                title: 'Name',
                                controller: newReqController.nameController,
                                hintText: 'Name',
                              ),
                              InputField2(
                                title: 'Shop Name',
                                controller: newReqController.shopNameController,
                                hintText: 'Shop Name',
                              ),
                              InputField2(
                                title: 'Contact#',
                                controller: newReqController.contact1Controller,
                                hintText: 'Contact#',
                              ),
                              InputField2(
                                title: 'Contact#',
                                controller: newReqController.contact2Controller,
                                hintText: 'Contact#',
                              ),
                              InputField2(
                                title: 'Address',
                                controller: newReqController.addressController,
                                hintText: 'Address',
                              ),
                              //language select dropdown
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Obx(() {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: AppText(
                                          text: 'Language',
                                          color: Constants.BLACK_COLOR,
                                          fontSize: AppDimensions.FONT_SIZE_14,
                                          fontWeight: FontWeights.bold,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Directionality(
                                          textDirection: context.locale
                                                      .toString() ==
                                                  'ur'
                                              ? directionRtr
                                              : directionLtr,
                                          child: DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                              //Add isDense true and zero Padding.
                                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            customButton: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    context.locale.toString() ==
                                                            'ur'
                                                        ? const Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            color: Colors.black,
                                                          )
                                                        : const SizedBox.shrink(),
                                                    context.locale.toString() ==
                                                            'ur'
                                                        ? const Spacer()
                                                        : const SizedBox.shrink(),
                                                    AppText(
                                                      text: newReqController
                                                              .selectedValue
                                                              ?.value ??
                                                          'Select Language',
                                                      color: Constants.BLACK_COLOR,
                                                      fontSize: AppDimensions
                                                          .FONT_SIZE_14,
                                                      fontWeight:
                                                          FontWeights.medium,
                                                    ),
                                                    context.locale.toString() ==
                                                            'ur'
                                                        ? const SizedBox.shrink()
                                                        : const Spacer(),
                                                    context.locale.toString() ==
                                                            'ur'
                                                        ? const SizedBox.shrink()
                                                        : const Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            color: Colors.black,
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            isExpanded: true,
                                            hint: AppText(
                                              text: 'Select Language',
                                              color: Constants.BLACK_COLOR,
                                              fontSize: AppDimensions.FONT_SIZE_14,
                                              fontWeight: FontWeights.medium,
                                            ),
                                            alignment: Alignment.centerLeft,
                                            items: newReqController.languageList
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: AppText(
                                                        text: item,
                                                        fontSize: AppDimensions
                                                            .FONT_SIZE_14,
                                                        fontWeight:
                                                            FontWeights.regular,
                                                        color:
                                                            Constants.BLACK_COLOR,
                                                      ),
                                                    ))
                                                .toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select scheme.';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              newReqController.selectedValue
                                                  ?.value = value.toString();
                                              //Do something when changing the item if you want.
                                            },
                                            onSaved: (value) {
                                              newReqController.selectedValue
                                                  ?.value = value.toString();
                                            },
                                            buttonStyleData: const ButtonStyleData(
                                              height: 60,
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 10),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                              ),
                                              iconSize: 30,
                                              iconDisabledColor: Colors.transparent,
                                              iconEnabledColor: Colors.transparent,
                                            ),
                                            dropdownStyleData: DropdownStyleData(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(() {
                        return newReqController.isSave.isTrue
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Constants.PRIMARY_COLOR,
                                ),
                              )
                            : AppButton(
                                width: 170.w,
                                btnText: 'Save',
                                onPressed: () {
                                  if (newReqController
                                          .nameController.text.isEmpty ||
                                      newReqController
                                          .qtyController.text.isEmpty ||
                                      newReqController
                                          .shopNameController.text.isEmpty ||
                                      newReqController
                                          .contact1Controller.text.isEmpty ||
                                      newReqController
                                          .addressController.text.isEmpty) {
                                    Utils.appSnackBar(
                                        //Usman_04052023
                                        subtitle: 'Please Select Type',
                                        title: 'Error');
                                  } else if (newReqController
                                              .selectedValue?.value ==
                                          'Select Language' ||
                                      newReqController.selectedItemName?.value ==
                                          'Item name') {
                                    Utils.appSnackBar(
                                        subtitle:
                                            'Please select item name and language',
                                        title: 'Error');
                                  } else {
                                    if (int.parse(newReqController
                                            .qtyController.text
                                            .trim()) <
                                        int.parse(
                                            newReqController.minQty?.value ??
                                                '0')) {
                                      Utils.appSnackBar(
                                        title: 'Error',
                                        subtitle:
                                            'Value should be greater than ${newReqController.minQty?.value}',
                                      );
                                      log('enter max than ${newReqController.minQty?.value}');
                                    } else {
                                      newReqController.savePublicityData(
                                          '${newReqController.selectedItemName?.value}',
                                          newReqController.qtyController.text
                                              .trim(),
                                          newReqController.rate.value,
                                          newReqController.totalAmount.value,
                                          newReqController.nameController.text
                                              .trim(),
                                          newReqController.shopNameController.text
                                              .trim(),
                                          newReqController.contact1Controller.text
                                              .trim(),
                                          newReqController.contact2Controller.text
                                              .trim(),
                                          newReqController.addressController.text
                                              .trim(),
                                          '${newReqController.selectedValue?.value}',context);
                                    }
                                  }
                                },
                                height: 27.h,
                              );
                      })
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 110.w,
                child: Image.asset(AppImages.TQR_LOGO),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
