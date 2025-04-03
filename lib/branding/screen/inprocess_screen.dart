import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/branding/model/b_inprocess_model.dart';

import '../../common/custome_appbar.dart';
import '../../common/input_field2.dart';
import '../../common/table_widget.dart';
import '../../main.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/branding_controller.dart';
import '../controller/inprocess_controller.dart';

class InProcessScreen extends StatefulWidget {
  const InProcessScreen({Key? key}) : super(key: key);

  @override
  State<InProcessScreen> createState() => _InProcessScreenState();
}

class _InProcessScreenState extends State<InProcessScreen> {
  var inProcessController = Get.find<InProcessController>();
  var brandingController = Get.put(BrandingController());

     TextEditingController searchController = TextEditingController();
  List<BInProcessModel> filteredData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inProcessController.isLoading.value = true;
    Future.delayed(const Duration(microseconds: 400), () {
      Future.wait([inProcessController.getBInProcessData()]);
    });
     filteredData = inProcessController.bInProcessModel;
  }

  void filterData(String query) {
    setState(() {
      filteredData = inProcessController.bInProcessModel.where((item) {
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
                title: 'In Process',
                imgPath: AppImages.NEW_INPROGRESS_ICON,
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
                                                child: AppText(
                                                  text: 'Shop Name',
                                                  fontSize: AppDimensions
                                                      .FONT_SIZE_14,
                                                  fontWeight: FontWeights.bold,
                                                  color: Constants.BLACK_COLOR,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  right: 30.w,
                                                ),
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
                                  Expanded(
                                    child: Obx(() {
                                      return inProcessController 
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
                                              controller: inProcessController
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
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.close,
                                                                    size: 30,
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(0),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            scrollable: true,
                                                            insetPadding:
                                                                EdgeInsets.zero,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        0),
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            titlePadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        0),
                                                            content: Container(
                                                              height: 600,
                                                              width: 340.w,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        40.h,
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            10.h),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Constants
                                                                          .SECONDRY_COLOR,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500,
                                                                          spreadRadius:
                                                                              1,
                                                                          blurRadius:
                                                                              2,
                                                                          offset: const Offset(
                                                                              2,
                                                                              3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        AppText(
                                                                      text:
                                                                          'Details',
                                                                      fontSize:
                                                                          AppDimensions
                                                                              .FONT_SIZE_24,
                                                                      fontWeight:
                                                                          FontWeights
                                                                              .semiBold,
                                                                      color: Constants
                                                                          .WHITE_COLOR,
                                                                    ),
                                                                  ),
                                                                  //branding type dropdown
                                                                  Obx(() {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                AppText(
                                                                              text: 'Branding Type',
                                                                              color: Constants.BLACK_COLOR,
                                                                              fontSize: AppDimensions.FONT_SIZE_14.sp,
                                                                              fontWeight: FontWeights.bold,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                IgnorePointer(
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
                                                                                          text: '${filteredData[index].brandingType}',
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
                                                                                  'Select Scheme',
                                                                                  style: TextStyle(fontSize: 14),
                                                                                ),
                                                                                alignment: Alignment.centerLeft,
                                                                                items: inProcessController.brandingTypeList
                                                                                    .map((item) => DropdownMenuItem<String>(
                                                                                          value: item,
                                                                                          alignment: Alignment.centerLeft,
                                                                                          child: AppText(
                                                                                            text: item,
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
                                                                                  inProcessController.selectedValue?.value = value.toString();
                                                                                  //Do something when changing the item if you want.
                                                                                },
                                                                                onSaved: (value) {
                                                                                  inProcessController.selectedValue?.value = value.toString();
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
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                                  SizedBox(
                                                                    height:
                                                                        20.w,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        /*Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      AppText(
                                                                        text: 'Sign Board',
                                                                        color: Constants
                                                                            .BLACK_COLOR,
                                                                        fontSize: AppDimensions
                                                                            .FONT_SIZE_14.sp,
                                                                        fontWeight:
                                                                        FontWeights.bold,
                                                                      ),
                                                                      SignboardBtnWidget(
                                                                        onPressed: () =>
                                                                            brandingController
                                                                                .pickFromGallery(),
                                                                        backgroundColor:
                                                                        MaterialStateProperty
                                                                            .all<Color>(
                                                                            Constants
                                                                                .PRIMARY_COLOR),
                                                                      ),
                                                                      SignboardBtnWidget(
                                                                        onPressed: () =>
                                                                            brandingController
                                                                                .pickFromCamera(),
                                                                        btnText: 'Upload new',
                                                                        backgroundColor:
                                                                        MaterialStateProperty
                                                                            .all<Color>(
                                                                            Constants
                                                                                .PRIMARY_COLOR),
                                                                      ),
                                                                    ],
                                                                  ),*/
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 20.w),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              InputField2(
                                                                                title: 'Name',
                                                                                controller: inProcessController.nameController,
                                                                                hintText: '${filteredData[index].name}',
                                                                                readOnly: true,
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsets.symmetric(vertical: 25.h),
                                                                                child: InputField2(
                                                                                  title: 'Shop Name',
                                                                                  controller: inProcessController.shopNameController,
                                                                                  hintText: '${filteredData[index].shopName}',
                                                                                  readOnly: true,
                                                                                ),
                                                                              ),
                                                                              InputField2(
                                                                                title: 'Contact#',
                                                                                controller: inProcessController.contact1Controller,
                                                                                hintText: '${filteredData[index].contactNo}',
                                                                                readOnly: true,
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsets.symmetric(vertical: 25.h),
                                                                                child: InputField2(
                                                                                  title: 'Contact#',
                                                                                  controller: inProcessController.contact2Controller,
                                                                                  hintText: '${filteredData[index].contactNo2}',
                                                                                  readOnly: true,
                                                                                ),
                                                                              ),
                                                                              InputField2(
                                                                                title: 'Address',
                                                                                controller: inProcessController.addressController,
                                                                                hintText: '${filteredData[index].address}',
                                                                                readOnly: true,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.h,
                                                                              ),
                                                                              //language select dropdown
                                                                              Obx(() {
                                                                                return Padding(
                                                                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: AppText(
                                                                                          text: 'Language',
                                                                                          color: Constants.BLACK_COLOR,
                                                                                          fontSize: AppDimensions.FONT_SIZE_14,
                                                                                          fontWeight: FontWeights.bold,
                                                                                        ),
                                                                                      ),
                                                                                      //language select dropdown
                                                                                      Expanded(
                                                                                        flex: 2,
                                                                                        child: IgnorePointer(
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
                                                                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                                                                                      text: '${filteredData[index].language}',
                                                                                                      color: Constants.BLACK_COLOR,
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
                                                                                            hint: AppText(
                                                                                              text: 'Select Language',
                                                                                              color: Constants.BLACK_COLOR,
                                                                                              fontSize: AppDimensions.FONT_SIZE_14,
                                                                                              fontWeight: FontWeights.medium,
                                                                                            ),
                                                                                            alignment: Alignment.centerLeft,
                                                                                            items: inProcessController.languageList
                                                                                                .map((item) => DropdownMenuItem<String>(
                                                                                                      value: item,
                                                                                                      alignment: Alignment.centerLeft,
                                                                                                      child: AppText(
                                                                                                        text: item,
                                                                                                        fontSize: AppDimensions.FONT_SIZE_14,
                                                                                                        fontWeight: FontWeights.regular,
                                                                                                        color: Constants.BLACK_COLOR,
                                                                                                      ),
                                                                                                    ))
                                                                                                .toList(),
                                                                                            validator: (value) => null,
                                                                                            /*(
                                                                                          value) {
                                                                                        if (value ==
                                                                                            null) {
                                                                                          return 'Please select scheme.';
                                                                                        }
                                                                                        return null;
                                                                                      },*/
                                                                                            onChanged: (value) {
                                                                                              inProcessController.langValue?.value = value.toString();
                                                                                              //Do something when changing the item if you want.
                                                                                            },
                                                                                            onSaved: (value) {
                                                                                              inProcessController.langValue?.value = value.toString();
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
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              }),
                                                                              /*Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                              top: 15),
                                                                          child: AppButton(
                                                                            width: 170.w,
                                                                            btnText: 'Save',
                                                                            onPressed: () {
                                                                              Utils
                                                                                  .toastMessage(
                                                                                  'We are working on it');
                                                                            },
                                                                            height: 27.h,
                                                                          ),
                                                                        ),*/
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    transTxt:
                                                        '${filteredData[index].shopName}',
                                                    dateTxt:
                                                        '${filteredData[index].requestDate}',
                                                    status:
                                                        '   ${filteredData[index].status}',
                                                  );
                                                },
                                                itemExtent: 50,
                                                shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                controller: inProcessController
                                                    .scrollController,
                                                itemCount: filteredData.length,
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
      ),
    );
  }
}
