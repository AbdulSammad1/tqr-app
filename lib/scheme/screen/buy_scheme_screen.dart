import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/pdf_view/screen/pdf_view_screen.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_loader.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../common/custome_appbar.dart';
import '../../login/controller/login_controller.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_button.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/scheme_controller.dart';

class BuySchemeScreen extends StatefulWidget {
  const BuySchemeScreen({Key? key}) : super(key: key);

  @override
  State<BuySchemeScreen> createState() => _BuySchemeScreenState();
}

class _BuySchemeScreenState extends State<BuySchemeScreen> {
  dynamic value;
  var loginController = Get.find<LoginController>();
  var data = Get.arguments;

  var schemeController = Get.find<SchemeController>();

  bool isSubmit = false;
  

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 600), () async {
      appLoader(context, Constants.PRIMARY_COLOR);
     
      bool submit = await schemeController.buySchemeMethodBool();

      setState(() {
        isSubmit = submit;
      });
        
      print('isSubmit $isSubmit');
      if(data !=null){
        loginController.selectedValue?.value = data;
      }else{
        loginController.selectedValue?.value = '';
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.w, right: 16.w),
                      child: const SizedBox.shrink(),

                    ),
                    CustomAppbar(title: 'Scheme',imgPath: AppImages.NEW_SCHEME_ICON, buttonWidth: 80.w,),

                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50.w,
                          ),
                          AppText(
                            text: 'Select Scheme',
                            fontSize: AppDimensions.FONT_SIZE_20,
                            fontWeight: FontWeights.bold,
                            color: Constants.BLACK_COLOR,
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Obx(() {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60.w,
                                  vertical: 10.w
                              ),
                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                customButton: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        context.locale.toString() == 'ur'
                                            ? const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        )
                                            : const SizedBox.shrink(),
                                        context.locale.toString() == 'ur'
                                            ? const Spacer()
                                            : const SizedBox.shrink(),
                                        AppText(
                                          text: loginController.selectedValue
                                              ?.value ?? 'Select Scheme',
                                          fontSize: AppDimensions.FONT_SIZE_14,
                                          fontWeight: FontWeights.medium,
                                        ),
                                        context.locale.toString() == 'ur'
                                            ? const SizedBox.shrink()
                                            : const Spacer(),
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
                                items: schemeController.schemeModelList
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: '${item.schemeName}',
                                      alignment: Alignment.centerLeft,
                                      child: AppText(
                                        text: '${item.schemeName}',
                                        fontSize: AppDimensions.FONT_SIZE_14,
                                        fontWeight: FontWeights.regular,
                                      ),
                                    )).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select scheme.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  loginController.selectedValue?.value = '$value';
                                  Future.delayed(const Duration(microseconds: 900),(){
                                    schemeController.focusNode.requestFocus();
                                  });
                                  //Do something when changing the item if you want.
                                },
                                onSaved: (value) {
                                  loginController.selectedValue?.value = '$value';
                                },
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10),

                                ),
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
                            );
                          }),
                          //pdf button
                          Obx(() {
                            return loginController.selectedValue?.value == ''
                                ? const SizedBox.shrink()
                                :  Padding(
                              padding:
                              EdgeInsets.symmetric(
                                  horizontal: 55.w, vertical: 10.w),
                              child: ActionChip(
                                label: Column(
                                  mainAxisAlignment: context.locale
                                      .toString() ==
                                      'ur'
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment
                                      .start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5,vertical: 8),
                                      child: Image.asset(AppImages.NEW_PDF_ICON,width: 70.w,height:70.w,),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  appLoader(context, Constants.PRIMARY_COLOR);
                                  Utils.toastMessage('Please wait...',);
                                  //select pdf according to scheme
                                  for (var element
                                  in schemeController.schemeModelList) {
                                    if (element.schemeName ==
                                        loginController.selectedValue?.value) {
                                      final url = '${element.attachmentPath}';
                                      final file = await PdfApi.loadFromNetwork(
                                          url);
                                      openPdf(file);
                                      if (kDebugMode) {
                                        print('pdf: ${element.attachmentPath}');
                                      }
                                    }
                                  }
                                },
                                padding: const EdgeInsets.all(0),
                                tooltip: 'Open pdf',
                                visualDensity: VisualDensity.compact,
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            );
                          }),
                          //quantity widget
                          Padding(
                            padding:
                            EdgeInsets.only(top: 10.w, right: 16),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppText(
                                      text: 'Quantity',
                                      fontWeight: FontWeights.semiBold,
                                      color: Constants.BLACK_COLOR,
                                      fontSize: AppDimensions.FONT_SIZE_18,
                                    ),
                                    SizedBox(
                                      height: 4.w,
                                    ),
                                    Container(
                                      width: 150.w,
                                      height: 32.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Constants.GREY_COLOR,
                                        ),
                                      ),
                                      child:
                                      context.locale.toString() == 'ur'
                                          ? Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 25.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            // margin: EdgeInsets.only(right: 20.w),
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                schemeController.addMethod();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Colors.transparent,
                                                padding: EdgeInsets.zero,
                                                shadowColor: Colors.transparent,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: SizedBox(
                                                height: 15.h,
                                                width: 55.w,
                                                child: TextFormField(
                                                  controller: schemeController
                                                      .controller,
                                                  focusNode: schemeController.focusNode,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  autofocus: true,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15.sp,
                                                    color:
                                                    Constants.BLACK_COLOR,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15.sp,
                                                    ),
                                                    contentPadding:
                                                    EdgeInsets.only(
                                                        left: 5.h,
                                                        bottom: 2.h),
                                                    isDense: true,
                                                    enabledBorder:
                                                    const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Constants
                                                              .PRIMARY_COLOR),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Container(
                                            width: 25.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                schemeController.minusMethod();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Colors.transparent,
                                                padding: EdgeInsets.zero,
                                                shadowColor: Colors.transparent,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ) : Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 25.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                schemeController.minusMethod();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Colors.transparent,
                                                padding: EdgeInsets.zero,
                                                shadowColor: Colors.transparent,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: SizedBox(
                                                height: 15.h,
                                                width: 55.w,
                                                child: TextFormField(
                                                  controller: schemeController
                                                      .controller,
                                                  focusNode: schemeController.focusNode,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15.sp,
                                                    color:
                                                    Constants.BLACK_COLOR,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15.sp,
                                                    ),
                                                    contentPadding:
                                                    EdgeInsets.only(
                                                        left: 5.h,
                                                        bottom: 2.h),
                                                    isDense: true,
                                                    enabledBorder:
                                                    const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Constants
                                                              .PRIMARY_COLOR),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Container(
                                            width: 25.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            // margin: EdgeInsets.only(right: 20.w),
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                schemeController.addMethod();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Colors.transparent,
                                                padding: EdgeInsets.zero,
                                                shadowColor: Colors.transparent,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Obx(() {
                            return SizedBox(
                              height: loginController.isExpanded.value
                                  ? 5.w
                                  : 40.w,
                            );
                          }),
                          AppButton(
                              btnText: 'Submit',
                              color: isSubmit ? Constants.SECONDRY_COLOR : Constants.GREY_COLOR,
                              onPressed: isSubmit == false ? null : () async {
                                if (loginController.selectedValue?.value ==
                                    '') {
                                  Utils.appSnackBar(
                                    subtitle: 'Please select scheme',
                                  );
                                } else if (schemeController
                                    .controller.text.isEmpty) {
                                  Utils.appSnackBar(
                                    subtitle: 'Please enter quantity',
                                  );
                                } else {
                                  schemeController.memberName.value =
                                  '${loginController.selectedValue?.value}';
                                  appLoader(context, Constants.PRIMARY_COLOR);
                                  schemeController
                                      .qtyValidation(
                                      '${loginController.selectedValue
                                          ?.value}',schemeController.controller.text.trim());
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
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


  void openPdf(File file) {
    Get.to(() => PdfViewScreen(file: file,));
  }

}
