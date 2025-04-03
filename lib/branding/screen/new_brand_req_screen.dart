import 'dart:ui' as UI;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../common/custome_appbar.dart';
import '../../common/input_field2.dart';
import '../../login/controller/login_controller.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_button.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/branding_controller.dart';
import '../widgets/signboard_btn_widget.dart';

class NewBrandReqScreen extends StatefulWidget {
  const NewBrandReqScreen({super.key});

  @override
  State<NewBrandReqScreen> createState() => _NewBrandReqScreenState();
}

class _NewBrandReqScreenState extends State<NewBrandReqScreen> {
  var loginController = Get.find<LoginController>();
  var brandingController = Get.find<BrandingController>();
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;
  String image1 = '';
  String image2 = '';

  List<String> frontImages = ['', '', ''];
  List<String> backImages = ['', '', ''];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 300), () {
      Future.wait([
        brandingController.getBrandingTypeData(context),
        brandingController.getNewRequestData(),
      ]);
    });
  }

  void showImageDialog(String text, Function()? onTap) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!!',
                      style: TextStyle(fontSize: 18.sp, color: Colors.black)),
        content:
            Text(text, style: TextStyle(fontSize: 18.sp, color: Colors.black)),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:  Text('No',
                      style: TextStyle(fontSize: 18.sp, color: Colors.black))),
          ElevatedButton(
            onPressed: onTap,
            child:  Text('Yes',
                      style: TextStyle(fontSize: 18.sp, color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void callFrontModelSheet() {
    if (frontImages[0] == '') {
      showFrontModalSheet();
    }
    else{
      showImageDialog('Kia aap mazeed picture upload karna chahte hain', () {
        Navigator.of(context).pop(); showFrontModalSheet();});
    }
  }

   void callBackModelSheet() {
    if (backImages[0] == '') {
      showBackModalSheet();
    }
    else{
      showImageDialog('Kia aap mazeed picture upload karna chahte hain', () {
        Navigator.of(context).pop();
        showBackModalSheet();
      });
    }
  }

  void showFrontModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: 120.h,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox.shrink(),
                    Text(
                      'Upload Front Images',
                      style: TextStyle(fontSize: 18.sp, color: Colors.black),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ))
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          pickImageMethod(true, 0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: frontImages[0] != ''
                                  ? Constants.PRIMARY_COLOR
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(10.w)),
                          padding: EdgeInsets.all(10.w),
                          child: const Text('Image 1'),
                        ),
                      ),
                      InkWell(
                        onTap: frontImages[0] != ''
                            ? () {
                               
                                        pickImageMethod(true, 1);
                                 
                              }
                            : () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: frontImages[0] == ''
                                  ? Constants.GREY_COLOR
                                  : frontImages[1] != ''
                                      ? Constants.PRIMARY_COLOR
                                      : Colors.black,
                              borderRadius: BorderRadius.circular(10.w)),
                          padding: EdgeInsets.all(10.w),
                          child: const Text('Image 2'),
                        ),
                      ),
                      InkWell(
                          onTap: frontImages[0] != '' && frontImages[1] != ''
                              ? () {
                                 
                                      
                                        pickImageMethod(true, 2);
                                    
                                }
                              : () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: (frontImages[0] != '' &&
                                        frontImages[1] != '')
                                    ? Constants.BLACK_COLOR
                                    : frontImages[2] != ''
                                        ? Constants.PRIMARY_COLOR
                                        : Constants.GREY_COLOR,
                                borderRadius: BorderRadius.circular(10.w)),
                            padding: EdgeInsets.all(10.w),
                            child: const Text('Image 3'),
                          )),
                    ]),
              ],
            ),
          );
          //  PickerBottomSheet(
          //   onGalleryClick: () async {
          //     brandingController
          //         .generateGRandomNum();
          //    image1 = await brandingController
          //         .pickFromGallery();
          //     Navigator.of(context).pop();
          //     // Utils.toastMessage('please wait...');
          //     // brandingController.ftpImageName().then((value) => {
          //     //
          //     // });

          //   },
          //   onCameraClick: () async {
          //     brandingController
          //     .generateGRandomNum();
          //    image1 = await brandingController
          //         .pickFromCamera();

          //     Navigator.of(context).pop();
          //     // Utils.toastMessage('please wait...');
          //     // brandingController.ftpImageName().then((value) => {
          //     //  // logger.i('ftpImageName: ${value}'),
          //     //
          //     // });
          //   },
          // );
        });
  }

  void showBackModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: 120.h,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox.shrink(),
                    Text(
                      'Upload Display Images',
                      style: TextStyle(fontSize: 18.sp, color: Colors.black),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ))
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          pickImageMethod(false, 0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: backImages[0] != ''
                                  ? Constants.PRIMARY_COLOR
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(10.w)),
                          padding: EdgeInsets.all(10.w),
                          child: const Text('Image 1'),
                        ),
                      ),
                      InkWell(
                        onTap: backImages[0] != ''
                            ? () {
                              
                                        pickImageMethod(true, 1);
                               
                              }
                            : () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: backImages[0] == ''
                                  ? Constants.GREY_COLOR
                                  : backImages[1] != ''
                                      ? Constants.PRIMARY_COLOR
                                      : Colors.black,
                              borderRadius: BorderRadius.circular(10.w)),
                          padding: EdgeInsets.all(10.w),
                          child: const Text('Image 2'),
                        ),
                      ),
                      InkWell(
                          onTap: (backImages[0] != '' && backImages[1] != '')
                              ? () {
                                 
                                        Navigator.of(context).pop();
                                        pickImageMethod(true, 2);
                                 
                                }
                              : () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color:
                                    (backImages[0] != '' && backImages[1] != '')
                                        ? Constants.BLACK_COLOR
                                        : backImages[2] != ''
                                            ? Constants.PRIMARY_COLOR
                                            : Constants.GREY_COLOR,
                                borderRadius: BorderRadius.circular(10.w)),
                            padding: EdgeInsets.all(10.w),
                            child: const Text('Image 3'),
                          )),
                    ]),
              ],
            ),
          );
          // return PickerBottomSheet(
          //   onGalleryClick: () async {
          //     brandingController
          //         .generateCRandomNum();
          //     image2 =
          //         await brandingController
          //             .pickFromGallery1();
          //     Navigator.of(context).pop();
          //   },
          //   onCameraClick: () async {
          //     brandingController
          //         .generateCRandomNum();
          //     image2 =
          //         await brandingController
          //             .pickFromCamera1();

          //     Navigator.of(context).pop();
          //   },
          // );
        });
  }

  void pickImageMethod(bool isFront, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Select Method',
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            'Pick an image',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.PRIMARY_COLOR),
                onPressed: () async {
                  // Navigator.of(context).pop();
                  brandingController.generateGRandomNum();
                  image1 = await brandingController.pickFromCamera();

                  isFront
                      ? (frontImages[index] = image1)
                      : (backImages[index] = image1);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  setState(() {});

                  isFront ?  callFrontModelSheet() : callBackModelSheet();
                  // setState(() {
                  //   getImage(false);
                  // });
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(color: Colors.white),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.PRIMARY_COLOR),
                onPressed: () async {
                  brandingController.generateGRandomNum();
                  image1 = await brandingController.pickFromGallery();

                  isFront
                      ? (frontImages[index] = image1)
                      : (backImages[index] = image1);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  setState(() {});

                  // setState(() {
                  //   getImage(true);
                  // });
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: directionLtr,
      child: WillPopScope(
        onWillPop: () async {
          if (brandingController.fImGSelect.isTrue ||
              brandingController.bImGSelect.isTrue) {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AlertDialog(
                    title: AppText(
                      text: context.locale.toString() == 'ur'
                          ? '?Are you sure you want to go back'
                          : 'Are you sure you want to go back?',
                      fontSize: 16,
                      fontWeight: FontWeights.bold,
                      color: Constants.BLACK_COLOR,
                      softWrap: true,
                    ),
                    actions: [
                      Directionality(
                        textDirection: directionLtr,
                        child: Row(
                          mainAxisAlignment: context.locale.toString() == 'ur'
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  side: WidgetStateProperty.all(
                                    const BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                  ),
                                  backgroundColor: WidgetStateProperty.all(
                                    Constants.PRIMARY_COLOR,
                                  ),
                                ),
                                child: AppText(
                                  text: 'No',
                                  fontSize: 16,
                                  fontWeight: FontWeights.medium,
                                  color: Constants.WHITE_COLOR,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Future.delayed(
                                    const Duration(milliseconds: 300),
                                    () => Get.back());
                              },
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                side: WidgetStateProperty.all(
                                  const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  Constants.PRIMARY_COLOR,
                                ),
                              ),
                              child: AppText(
                                text: 'Yes',
                                fontSize: 16,
                                fontWeight: FontWeights.medium,
                                color: Constants.WHITE_COLOR,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                });
          } else {
            Navigator.pop(context);
          }

          return false;
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: Column(
              children: [
                CustomAppbar(
                  imgPath: AppImages.NEW_REQUEST_ICON,
                  title: 'New Request',
                  buttonWidth: 70.w,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          //save branding dropdown
                          Obx(() {
                            return Directionality(
                              textDirection: directionLtr,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text: 'Branding Type',
                                      color: Constants.BLACK_COLOR,
                                      fontSize: AppDimensions.FONT_SIZE_14.sp,
                                      fontWeight: FontWeights.bold,
                                    ),
                                  ),
                                  //branding type dropdown
                                  Expanded(
                                    child: Directionality(
                                      textDirection:
                                          context.locale.toString() == 'ur'
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
                                              vertical: 5, horizontal: 10),
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
                                                  text: brandingController
                                                          .selectedValue
                                                          ?.value ??
                                                      'Select Scheme',
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
                                        hint: const Text(
                                          'Select Scheme',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        items: brandingController.nBTypeModel
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.brandingType,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: AppText(
                                                    text:
                                                        '${item.brandingType}',
                                                    fontSize: AppDimensions
                                                        .FONT_SIZE_14,
                                                    fontWeight:
                                                        FontWeights.regular,
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
                                          brandingController.selectedValue
                                              ?.value = value.toString();
                                          //Do something when changing the item if you want.
                                        },
                                        onSaved: (value) {
                                          brandingController.selectedValue
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
                              ),
                            );
                          }),
                          SizedBox(
                            height: 20.w,
                          ),
                          //upload signboard btn
                          Directionality(
                            textDirection: directionLtr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: 'Sign Board',
                                  color: Constants.BLACK_COLOR,
                                  fontSize: AppDimensions.FONT_SIZE_14.sp,
                                  fontWeight: FontWeights.bold,
                                ),
                                Obx(() {
                                  return SignboardBtnWidget(
                                    onPressed: () {
                                      callFrontModelSheet();
                                    },
                                    backgroundColor:
                                        frontImages[0].obs != ''
                                            ? WidgetStateProperty.all<Color>(
                                                Constants.PRIMARY_COLOR)
                                            : WidgetStateProperty.all<Color>(
                                                Constants.SECONDRY_COLOR),
                                  );
                                }),
                                Obx(() {
                                  return SignboardBtnWidget(
                                    onPressed: () {
                                      callBackModelSheet();
                                    },
                                    btnText: 'Upload display \npicture',
                                    backgroundColor:
                                       backImages[0].obs != ''
                                            ? WidgetStateProperty.all<Color>(
                                                Constants.PRIMARY_COLOR)
                                            : WidgetStateProperty.all<Color>(
                                                Constants.SECONDRY_COLOR),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.w),
                              child: Obx(() {
                                return Directionality(
                                  textDirection: directionLtr,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InputField2(
                                        title: 'Name',
                                        controller:
                                            brandingController.nameController,
                                      ),
                                      InputField2(
                                        title: 'Shop Name',
                                        controller: brandingController
                                            .shopNameController,
                                      ),
                                      InputField2(
                                        title: 'Contact#',
                                        controller: brandingController
                                            .contact1Controller,
                                      ),
                                      InputField2(
                                        title: 'Contact#',
                                        controller: brandingController
                                            .contact2Controller,
                                      ),
                                      InputField2(
                                        title: 'Address',
                                        controller: brandingController
                                            .addressController,
                                        hintText:
                                            '${brandingController.address}',
                                      ),
                                      //language select dropdown
                                      Obx(() {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: AppText(
                                                text: 'Language',
                                                color: Constants.BLACK_COLOR,
                                                fontSize:
                                                    AppDimensions.FONT_SIZE_14,
                                                fontWeight: FontWeights.bold,
                                              ),
                                            ),
                                            //language select dropdown
                                            Expanded(
                                              flex: 2,
                                              child: Directionality(
                                                textDirection:
                                                    context.locale.toString() ==
                                                            'ur'
                                                        ? directionRtr
                                                        : directionLtr,
                                                child: DropdownButtonFormField2(
                                                  decoration: InputDecoration(
                                                    //Add isDense true and zero Padding.
                                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
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
                                                        vertical: 10,
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
                                                          AppText(
                                                            text: brandingController
                                                                    .langValue
                                                                    ?.value ??
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
                                                  hint: AppText(
                                                    text: 'Select Language',
                                                    color:
                                                        Constants.BLACK_COLOR,
                                                    fontSize: AppDimensions
                                                        .FONT_SIZE_14,
                                                    fontWeight:
                                                        FontWeights.medium,
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  items: brandingController
                                                      .languageList
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: AppText(
                                                              text: item,
                                                              fontSize:
                                                                  AppDimensions
                                                                      .FONT_SIZE_14,
                                                              fontWeight:
                                                                  FontWeights
                                                                      .regular,
                                                              color: Constants
                                                                  .BLACK_COLOR,
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
                                                    brandingController
                                                            .langValue?.value =
                                                        value.toString();
                                                    //Do something when changing the item if you want.
                                                  },
                                                  onSaved: (value) {
                                                    brandingController
                                                            .langValue?.value =
                                                        value.toString();
                                                  },
                                                  buttonStyleData:
                                                      const ButtonStyleData(
                                                    height: 60,
                                                    padding: EdgeInsets.only(
                                                        left: 20, right: 10),
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
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                      brandingController.isSave.isTrue
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: Constants.PRIMARY_COLOR,
                                              ),
                                            )
                                          : AppButton(
                                              width: 170.w,
                                              btnText: 'Save',
                                              onPressed: () {
                                                if (brandingController
                                                        .nameController
                                                        .text
                                                        .isEmpty ||
                                                    brandingController
                                                        .shopNameController
                                                        .text
                                                        .isEmpty ||
                                                    brandingController
                                                        .contact1Controller
                                                        .text
                                                        .isEmpty ||
                                                    brandingController
                                                        .addressController
                                                        .text
                                                        .isEmpty) {
                                                  Utils.appSnackBar(
                                                      subtitle:
                                                          'Please Select Item',
                                                      title: 'Error');
                                                } else if (brandingController
                                                            .selectedValue
                                                            ?.value ==
                                                        'Branding Type' ||
                                                    brandingController
                                                            .langValue?.value ==
                                                        'Select Language') {
                                                  Utils.appSnackBar(
                                                      subtitle:
                                                          'Please select branding type and language',
                                                      title: 'Error');
                                                } else if (frontImages[0]
                                                        == '' ||
                                                    backImages[0]
                                                        == '') {
                                                  Utils.appSnackBar(
                                                      subtitle:
                                                          'Please upload both front and display picture',
                                                      title: 'Error');
                                                }
                                                //else if (image1 == '' ||
                                                //     image2 == '') {
                                                //   Utils.appSnackBar(
                                                //       subtitle:
                                                //           'Please upload both front and new picture',
                                                //       title: 'Error');
                                                // }
                                                else {
                                                  // brandingController.ftpConnectMethod();

                                                  var front = [];
                                                  var back = [];
                                                  for (var i = 0; i < 3; i++) {
                                                    if (frontImages[i] != '') {
                                                      front.add(frontImages[i]);
                                                    }
                                                    if (backImages[i] != '') {
                                                      back.add(backImages[i]);
                                                    }
                                                  }

                                                  brandingController
                                                      .saveBrandingData(
                                                    '${brandingController.selectedValue?.value}',
                                                    brandingController
                                                        .nameController.text
                                                        .trim(),
                                                    brandingController
                                                        .shopNameController.text
                                                        .trim(),
                                                    brandingController
                                                        .contact1Controller.text
                                                        .trim(),
                                                    brandingController
                                                        .contact2Controller.text
                                                        .trim(),
                                                    brandingController
                                                        .addressController.text
                                                        .trim(),
                                                    '${brandingController.langValue?.value}',
                                                    frontImages,
                                                    backImages,
                                                  );
                                                }
                                              },
                                              height: 27.h,
                                            ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
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
            )),
          ),
        ),
      ),
    );
  }
}
