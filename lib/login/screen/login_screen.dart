import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/dashboard/screen/dashboard_screen.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/font_weights.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_images.dart';

import '../../res/routes/route_name.dart';
import '../../utils/app_button.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loginController = Get.find<LoginController>();
  final userTypeList = ['Distributor', 'Retailer'];

  //String? selectedValue;
  // bool val = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: EdgeInsets.only(top: 50.w, right: 16.w),
                      child: const SizedBox.shrink(),
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 200.w,
                          child: Image.asset(AppImages.TQR_LOGO),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: 'Select Customer Category',
                              fontSize: AppDimensions.FONT_SIZE_20,
                              fontWeight: FontWeights.semiBold,
                              color: Constants.BLACK_COLOR,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Obx(() {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 60.w, vertical: 10.w),
                            child: DropdownButtonFormField2(
                              style: TextStyle(fontSize:AppDimensions.FONT_SIZE_18 ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        text: loginController
                                                .selectedValue?.value ??
                                            'Select Scheme',
                                        fontSize: AppDimensions.FONT_SIZE_16,
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
                              items: userTypeList
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        alignment: Alignment.centerLeft,
                                        child: AppText(
                                          text: item,
                                          fontSize: AppDimensions.FONT_SIZE_16,
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
                                loginController.selectedValue?.value =
                                    value.toString();
                              },
                              onSaved: (value) {
                                loginController.selectedValue?.value =
                                    value.toString();
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
                          );
                        }),
                        SizedBox(
                          height: 10.w,
                        ),
                        AppButton(
                          btnText: 'NEXT',
                          color: Constants.SECONDRY_COLOR,
                          onPressed: () {
                            if (loginController.selectedValue?.value == '') {
                              Utils.appSnackBar();
                            } else if (loginController.selectedValue?.value ==
                                'Distributor') {
                              Get.toNamed(
                                RouteName.dspLoginScreen,
                              );

                            } else {
                              Get.toNamed(
                                RouteName.phoneScreen,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppImages.SAZ_FOTTER,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

