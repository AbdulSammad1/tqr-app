import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/custome_appbar.dart';
import '../../common/input_field2.dart';
import '../../common/table_widget.dart';
import '../../main.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../conrtroller/p_history_controller.dart';
import '../model/p_history_model.dart';

class PHistoryScreen extends StatefulWidget {
  const PHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PHistoryScreen> createState() => _PHistoryScreenState();
}

class _PHistoryScreenState extends State<PHistoryScreen> {
  var pHistoryController = Get.find<PHistoryController>();
      TextEditingController searchController = TextEditingController();
  List<PHistoryModel> filteredData = [];



  @override
  void initState() {
    super.initState();
    pHistoryController.getPHistoryData();
      filteredData = pHistoryController.pHistoryModel;
  }


   void filterData(String query) {
    setState(() {
      filteredData = pHistoryController.pHistoryModel.where((item) {
        final date = item.requestDate?.toLowerCase();
        final shopName = item.shopName?.toLowerCase();
        final status = item.status.toString().toLowerCase();
        final requestForm = item.address.toString().toLowerCase();
        final searchLower = query.toLowerCase();

        // Check if any of the fields contains the search query
        return date!.contains(searchLower) ||
            shopName!.contains(searchLower) ||
            requestForm.contains(searchLower) ||
            status.contains(searchLower);
      }).toList();
    });
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
                  buttonWidth: 80.w,

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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.w, right: 16.w),
                    child: const SizedBox.shrink(),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
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
                          Column(children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(

                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: AppText(
                                            text: 'Shop Name',
                                            fontSize: AppDimensions
                                                .FONT_SIZE_14,
                                            fontWeight: FontWeights.bold,
                                            color: Constants.BLACK_COLOR,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 30.w, ),
                                          child: AppText(
                                            text: 'Request Date',
                                            fontSize: AppDimensions
                                                .FONT_SIZE_14,
                                            fontWeight: FontWeights.bold,
                                            color: Constants.BLACK_COLOR,
                                          ),
                                        ),
                                        Expanded(
                                          child: AppText(
                                            text: 'Form',
                                            fontSize: AppDimensions
                                                .FONT_SIZE_14,
                                            fontWeight: FontWeights.bold,
                                            color: Constants.BLACK_COLOR,
                                          ),
                                        ),
                                        AppText(
                                          text: 'Status',
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
                          ],),
                          Expanded(
                            child: Obx(() {
                              return pHistoryController 
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
                                                  ):  Scrollbar(
                                controller: pHistoryController
                                    .scrollController,
                                thumbVisibility: true,
                                radius: const Radius.circular(5),
                                thickness: 5,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return TableWidget(
                                      onDetailTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              scrollable: true,
                                              insetPadding: EdgeInsets.zero,
                                              contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              titlePadding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 0),
                                              content: Container(
                                                height: 600,
                                                width: 340.w,
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 40.h,
                                                      margin:
                                                      EdgeInsets.only(bottom: 10.h),
                                                      decoration: BoxDecoration(
                                                        color: Constants.SECONDRY_COLOR,
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
                                                        text: 'Details',
                                                        fontSize:
                                                        AppDimensions.FONT_SIZE_24,
                                                        fontWeight:
                                                        FontWeights.semiBold,
                                                        color: Constants.WHITE_COLOR,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double
                                                          .infinity,
                                                      height:
                                                      100.h,
                                                      decoration:
                                                      BoxDecoration(
                                                        border:
                                                        Border.lerp(
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
                                                      child:
                                                      Column(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            AppText(
                                                                              text: 'Item Name',
                                                                              fontSize: AppDimensions.FONT_SIZE_14,
                                                                              fontWeight: FontWeights.bold,
                                                                              color: Constants.BLACK_COLOR,
                                                                            ),
                                                                            AppText(
                                                                              text: 'QTY',
                                                                              fontSize: AppDimensions.FONT_SIZE_14,
                                                                              fontWeight: FontWeights.bold,
                                                                              color: Constants.BLACK_COLOR,
                                                                            ),
                                                                            AppText(
                                                                              text: 'Rate',
                                                                              fontSize: AppDimensions.FONT_SIZE_14,
                                                                              fontWeight: FontWeights.bold,
                                                                              color: Constants.BLACK_COLOR,
                                                                            ),
                                                                            AppText(
                                                                              text: 'Amount',
                                                                              fontSize: AppDimensions.FONT_SIZE_14,
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
                                                                IgnorePointer(
                                                                  child: Obx(() {
                                                                    return Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            //item name dropdown
                                                                            Expanded(
                                                                              flex: 4,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(left: 5.w, right: 35.w),
                                                                                child: DropdownButtonFormField2(
                                                                                  decoration: InputDecoration(
                                                                                    //Add isDense true and zero Padding.
                                                                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                                    isDense: true,
                                                                                    contentPadding: EdgeInsets.zero,
                                                                                    border: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                  ),
                                                                                  customButton: Padding(
                                                                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                                                    child: Align(
                                                                                      alignment: Alignment.centerLeft,
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          context.locale.toString() == 'ur'
                                                                                              ? const Icon(
                                                                                            Icons.keyboard_arrow_down,
                                                                                            color: Colors.black,
                                                                                          )
                                                                                              : const SizedBox.shrink(),
                                                                                          context.locale.toString() == 'ur' ? const Spacer() : const SizedBox.shrink(),
                                                                                          AppText(
                                                                                            text: '${filteredData[index].item}',
                                                                                            fontSize: AppDimensions.FONT_SIZE_14,
                                                                                            fontWeight: FontWeights.medium,
                                                                                          ),
                                                                                          context.locale.toString() == 'ur' ? const SizedBox.shrink() : const Spacer(),
                                                                                          context.locale.toString() == 'ur'
                                                                                              ? const SizedBox.shrink()
                                                                                              : const Icon(
                                                                                            Icons.keyboard_arrow_down,
                                                                                            color: Colors.black,
                                                                                          ),

                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  isExpanded: true,
                                                                                  hint: const Text(
                                                                                    'Item name',
                                                                                    style: TextStyle(fontSize: 14),
                                                                                  ),
                                                                                  alignment: Alignment.centerLeft,
                                                                                  items: filteredData
                                                                                      .map((item) => DropdownMenuItem<String>(
                                                                                    value: '${item.item}',
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: AppText(
                                                                                      text: '${item.item}',
                                                                                      fontSize: AppDimensions.FONT_SIZE_14,
                                                                                      fontWeight: FontWeights.regular,
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
                                                                                    pHistoryController.selectedItemName?.value = value.toString();
                                                                                    //Do something when changing the item if you want.
                                                                                  },
                                                                                  onSaved: (value) {
                                                                                    pHistoryController.selectedItemName?.value = value.toString();
                                                                                  },
                                                                                  buttonStyleData: const ButtonStyleData(
                                                                                    height: 60,
                                                                                    padding: EdgeInsets.only(left: 20, right: 10),
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
                                                                                      borderRadius: BorderRadius.circular(15),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: AppText(
                                                                                text: '${filteredData[index].qty}',
                                                                                color: Constants.BLACK_COLOR,
                                                                                fontSize: AppDimensions.FONT_SIZE_13,
                                                                                fontWeight: FontWeights.medium,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: AppText(
                                                                                text: '${filteredData[index].rate}',
                                                                                color: Constants.BLACK_COLOR,
                                                                                fontSize: AppDimensions.FONT_SIZE_13,
                                                                                fontWeight: FontWeights.medium,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15),
                                                                                child: AppText(
                                                                                  text: '${filteredData[index].amount}',
                                                                                  color: Constants.BLACK_COLOR,
                                                                                  fontSize: AppDimensions.FONT_SIZE_13,
                                                                                  fontWeight: FontWeights.medium,
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
                                                                  }),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      child: Column(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              InputField2(
                                                                title: 'Name',
                                                                controller:
                                                                pHistoryController
                                                                    .nameController,
                                                                hintText: '${filteredData[index].name}',
                                                                readOnly: true,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 25.h),
                                                                child: InputField2(
                                                                  title: 'Shop Name',
                                                                  controller:
                                                                  pHistoryController
                                                                      .shopNameController,
                                                                  hintText: '${filteredData[index].shopName}',
                                                                  readOnly: true,
                                                                ),
                                                              ),
                                                              InputField2(
                                                                title: 'Contact#',
                                                                controller:
                                                                pHistoryController
                                                                    .contact1Controller,
                                                                hintText:  '${filteredData[index].contactNo}',
                                                                readOnly: true,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 25.h),
                                                                child: InputField2(
                                                                  title: 'Contact#',
                                                                  controller:
                                                                  pHistoryController
                                                                      .contact2Controller,
                                                                  hintText:  '${filteredData[index].contactNo2}',
                                                                  readOnly: true,
                                                                ),
                                                              ),
                                                              InputField2(
                                                                title: 'Address',
                                                                controller:
                                                                pHistoryController
                                                                    .addressController,
                                                                hintText:  '${filteredData[index].address}',
                                                                readOnly: true,
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              //language select dropdown
                                                              Obx(() {
                                                                return Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      15),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                        AppText(
                                                                          text:
                                                                          'Language',
                                                                          color: Constants
                                                                              .BLACK_COLOR,
                                                                          fontSize:
                                                                          AppDimensions
                                                                              .FONT_SIZE_14,
                                                                          fontWeight:
                                                                          FontWeights
                                                                              .bold,
                                                                        ),
                                                                      ),
                                                                      //language select dropdown
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                        IgnorePointer(
                                                                          child: DropdownButtonFormField2(
                                                                            decoration:
                                                                            InputDecoration(
                                                                              isDense:
                                                                              true,
                                                                              contentPadding:
                                                                              EdgeInsets
                                                                                  .zero,
                                                                              border:
                                                                              OutlineInputBorder(
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    10),
                                                                              ),
                                                                            ),
                                                                            customButton:
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .symmetric(
                                                                                  vertical:
                                                                                  10,
                                                                                  horizontal:
                                                                                  10),
                                                                              child:
                                                                              Align(
                                                                                alignment:
                                                                                Alignment
                                                                                    .centerLeft,
                                                                                child:
                                                                                Row(
                                                                                  mainAxisAlignment:
                                                                                  MainAxisAlignment
                                                                                      .spaceBetween,
                                                                                  children: [
                                                                                    context
                                                                                        .locale
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
                                                                                    context
                                                                                        .locale
                                                                                        .toString() ==
                                                                                        'ur'
                                                                                        ? const Spacer()
                                                                                        : const SizedBox
                                                                                        .shrink(),
                                                                                    AppText(
                                                                                      text: '${pHistoryController
                                                                                          .pHistoryModel[index].language}',
                                                                                      color: Constants
                                                                                          .BLACK_COLOR,
                                                                                      fontSize: AppDimensions
                                                                                          .FONT_SIZE_14,
                                                                                      fontWeight: FontWeights
                                                                                          .medium,
                                                                                    ),
                                                                                    context
                                                                                        .locale
                                                                                        .toString() ==
                                                                                        'ur'
                                                                                        ? const SizedBox
                                                                                        .shrink()
                                                                                        : const Spacer(),
                                                                                    context
                                                                                        .locale
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
                                                                            isExpanded:
                                                                            true,
                                                                            hint:
                                                                            AppText(
                                                                              text:
                                                                              'Select Language',
                                                                              color: Constants
                                                                                  .BLACK_COLOR,
                                                                              fontSize:
                                                                              AppDimensions
                                                                                  .FONT_SIZE_14,
                                                                              fontWeight:
                                                                              FontWeights
                                                                                  .medium,
                                                                            ),
                                                                            alignment:
                                                                            Alignment
                                                                                .centerLeft,
                                                                            items: pHistoryController
                                                                                .languageList
                                                                                .map((
                                                                                item) =>
                                                                                DropdownMenuItem<
                                                                                    String>(
                                                                                  value: item,
                                                                                  alignment: Alignment
                                                                                      .centerLeft,
                                                                                  child: AppText(
                                                                                    text: item,
                                                                                    fontSize: AppDimensions
                                                                                        .FONT_SIZE_14,
                                                                                    fontWeight: FontWeights
                                                                                        .regular,
                                                                                    color: Constants
                                                                                        .BLACK_COLOR,
                                                                                  ),
                                                                                ))
                                                                                .toList(),

                                                                            validator: (value) => null,
                                                                            onChanged:
                                                                                (
                                                                                value) {
                                                                                  pHistoryController
                                                                                  .langValue
                                                                                  ?.value =
                                                                                  value
                                                                                      .toString();
                                                                            },
                                                                            onSaved:
                                                                                (
                                                                                value) {
                                                                                  pHistoryController
                                                                                  .langValue
                                                                                  ?.value =
                                                                                  value
                                                                                      .toString();
                                                                            },
                                                                            buttonStyleData:
                                                                            const ButtonStyleData(
                                                                              height:
                                                                              60,
                                                                              padding: EdgeInsets
                                                                                  .only(
                                                                                  left:
                                                                                  20,
                                                                                  right:
                                                                                  10),
                                                                            ),
                                                                            iconStyleData:
                                                                            const IconStyleData(
                                                                              icon:
                                                                              Icon(
                                                                                Icons
                                                                                    .keyboard_arrow_down,
                                                                                color: Colors
                                                                                    .black,
                                                                              ),
                                                                              iconSize:
                                                                              30,
                                                                              iconDisabledColor:
                                                                              Colors
                                                                                  .transparent,
                                                                              iconEnabledColor:
                                                                              Colors
                                                                                  .transparent,
                                                                            ),
                                                                            dropdownStyleData:
                                                                            DropdownStyleData(
                                                                              decoration:
                                                                              BoxDecoration
                                                                                (
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    15),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },);
                                      },
                                      transTxt: '${pHistoryController
                                          .pHistoryModel[index].shopName}',
                                      dateTxt: '${pHistoryController
                                          .pHistoryModel[index].requestDate}',
                                      status: '${pHistoryController
                                          .pHistoryModel[index].status}',
                                    );
                                  },
                                  itemExtent: 50,
                                  shrinkWrap: true,
                                  controller: pHistoryController
                                      .scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: filteredData
                                      .length,),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
    ));
  }
}
