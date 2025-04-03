import 'dart:ui' as UI;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/font_weights.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../login/controller/login_controller.dart';
import '../../utils/app_button.dart';
import '../../utils/app_loader.dart';
import '../../utils/app_snackbar.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/phone_controller.dart';
import '../widget/phone_num_field.dart';

class PhoneScreen extends StatefulWidget {
  final String? userType;

  const PhoneScreen({Key? key, this.userType}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final phoneController = Get.find<PhoneController>();
  var loginController = Get.find<LoginController>();
  var data = Get.arguments;
  var numberPattren = RegExp(r'^[0-9]+$');
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;


  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }



  Future<String> getAdvertisingIdbyPackage() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String deviceIdentifier = packageInfo.buildNumber;

    // The advertising ID is the first 8 characters of the device identifier.
    final String advertisingId = deviceIdentifier.substring(0, 8);

    return advertisingId;
  }

  // Future<String> getAdvertisingId() async {
  //   final AdvertisingId advertisingId = AdvertisingId();
  //   final String aaid = await advertisingId.toString();

  //   // If the AAID is MASTER, treat it as if the user has not provided an AAID.
  //   if (aaid == 'MASTER') {
  //     return 'null';
  //   }

  //   return aaid;
  // }

  // Future<void> _getDeviceKey() async {
  //   var deviceInfo = DeviceInfoPlugin();

  //   // Get the advertising identifier
  //   AndroidDeviceInfo advertisingIdentifier = await deviceInfo.androidInfo;

  //   // Set the unique device key
  //   _deviceKey = advertisingIdentifier.id;
  //   print('advertising id: $_deviceKey');
  // }

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
                    padding: EdgeInsets.only(top: 5.w, right: 16.w),
                    child: const SizedBox.shrink(),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200.w,
                        child: Image.asset(AppImages.TQR_LOGO),
                      ),
                      AppText(
                        text: 'Retailer Login',
                        fontSize: AppDimensions.FONT_SIZE_20,
                        fontWeight: FontWeights.bold,
                        color: Constants.BLACK_COLOR,
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                       AppText(
                        text: 'WeSendOtpTxt',
                        fontSize: AppDimensions.FONT_SIZE_15,
                        fontWeight: FontWeights.semiBold,
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      //custom phoneNum
                      Directionality(
                        textDirection: context.locale.toString() == 'ur'
                            ? directionLtr
                            : directionLtr,
                        child: PhoneNumField(
                          controller: phoneController.phoneNumberController,
                          hintText: 'Enter your phone number',
                          onChanged: (value) {
                            if (phoneController
                                .phoneNumberController.text.isNotEmpty) {
                              phoneController.showHelperTxt.value = true;
                              phoneController.autofocus.value = true;
                            } else {
                              phoneController.showHelperTxt.value = false;
                              phoneController.showHelperTxt.value = false;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      AppButton(
                        btnText: 'NEXT',
                        width: 0.8.sw,
                        color: Constants.SECONDRY_COLOR,
                        onPressed: () async {
                          if (phoneController
                                  .phoneNumberController.text.isEmpty ||
                              phoneController.phoneNumberController.text
                                  .startsWith(
                                '1',
                              ) ||
                              phoneController.phoneNumberController.text
                                  .startsWith(
                                '2',
                              ) ||
                              phoneController.phoneNumberController.text
                                  .startsWith(
                                '4',
                              ) ||
                              phoneController.phoneNumberController.text
                                  .startsWith(
                                '5',
                              ) ||
                              phoneController.phoneNumberController.text
                                  .startsWith(
                                '6',
                              ) ||
                              phoneController.phoneNumberController.text
                                  .startsWith(
                                '7',
                              ) ||
                              phoneController.phoneNumberController.text
                                  .startsWith(
                                '8',
                              ) ||
                              phoneController.phoneNumberController.text
                                  .startsWith(
                                '9',
                              )) {
                            appSnackBar(
                                subtitle: 'Please enter valid phone number');
                          } else {
                            // phoneAuthMethod();
                            String versionNumber = await getAppVersion();
                            phoneController.genrate4RandomNum();
                            appLoader(context, Constants.PRIMARY_COLOR);
                            phoneController.phoneNumber =
                                phoneController.countryCode +
                                    phoneController.phoneNumberController.text
                                        .trim();
                            phoneController.replaceNum =
                                phoneController.phoneNumber.replaceAll('+', '');
                            
                            
                            phoneController.numAlreadyRegister(
                                phoneController.replaceNum, versionNumber);
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      FutureBuilder<String>(
                        future: getAppVersion(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text('Error loading version number');
                          } else {
                            String versionNumber = snapshot.data ?? '';
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                'Version $versionNumber',
                                style: TextStyle(
                                  fontSize: AppDimensions.FONT_SIZE_16,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.DARK_GREY_COLOR,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      NotUserWidget(
                        onTap: () async {
                          final Uri url =
                              Uri(scheme: 'tel', path: '021 38657729');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            // debugPrint('Could not launch $url');
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            )),
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
