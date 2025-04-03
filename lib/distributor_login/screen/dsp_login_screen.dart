import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_loader.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../common/input_field.dart';
import '../../main.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_button.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/dsp_login_controller.dart';

class DistributorLoginScreen extends StatefulWidget {
  const DistributorLoginScreen({Key? key}) : super(key: key);

  @override
  State<DistributorLoginScreen> createState() => _DistributorLoginScreenState();
}

class _DistributorLoginScreenState extends State<DistributorLoginScreen> {



    Future<String> getAppVersion() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    }

  //    Future<void> _getDeviceKey() async {
  //   var deviceInfo = DeviceInfoPlugin();

  //   // Get the advertising identifier
  //   AndroidDeviceInfo advertisingIdentifier = await deviceInfo.androidInfo;

  //   // Set the unique device key
  //   _deviceKey = advertisingIdentifier.id;
  //   print('advertising id: $_deviceKey');
  // }


  @override
  Widget build(BuildContext context) {
    var dspLoginController = Get.find<DspLoginController>();

  
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ListView(
                  children: [
                    Image.asset(
                      AppImages.SAZ_FAM_LOGO,
                      width: 130.w,
                      height: 160.w,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: AppText(
                        text: 'Distributor Login',
                        fontSize: AppDimensions.FONT_SIZE_22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Directionality(
                      textDirection: directionLtr,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                            ),
                            child: InputField(
                              controller: dspLoginController.userIdController,
                              padding: EdgeInsets.zero,
                              isShowTitle: true,
                              titleTxt: 'User ID',
                              hintText: 'Enter User ID',
                              keyboardType: TextInputType.text,
                              /*inputFormatter: [
                                  //limit to 6 characters
                                  LengthLimitingTextInputFormatter(12),
                                ],*/
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Obx(() {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: 'Password',
                                    fontSize: AppDimensions.FONT_SIZE_18,
                                    fontWeight: FontWeights.semiBold,
                                    color: Constants.BLACK_COLOR,
                                  ),
                                  TextFormField(
                                    controller: dspLoginController.passwordController,
                                    obscureText: dspLoginController.obSecureText.value,
                                    style: TextStyle(
                                      fontSize: AppDimensions.FONT_SIZE_18,
                                      fontWeight: FontWeights.regular,
                                      color: Constants.BLACK_COLOR,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      hintStyle: TextStyle(
                                        color: Constants.GREY_COLOR,
                                        fontSize: AppDimensions.FONT_SIZE_18,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Constants.GREY_COLOR),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: dspLoginController.obSecureText.value
                                            ? Icon(
                                                Icons.visibility_off,
                                                color: Constants.PRIMARY_COLOR,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                color: Constants.PRIMARY_COLOR,
                                              ),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          dspLoginController.togglePassword();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            height: 40.w,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: AppButton(
                              width: double.infinity,
                              btnText: 'Login',
                              color: Constants.SECONDRY_COLOR,
                              onPressed: () {
                                if (dspLoginController.userIdController.text.isEmpty ||
                                    dspLoginController.passwordController.text.isEmpty) {
                                  Utils.appSnackBar(
                                    subtitle: 'Please enter valid credentials',
                                    title: 'Error',
                                  );
                                } else {
                                  appLoader(context, Constants.PRIMARY_COLOR);
                                  dspLoginController.distributorLogin(
                                    userId: dspLoginController.userIdController.text.trim().toLowerCase(),
                                    password: dspLoginController.passwordController.text.trim(),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20.h,),
                           FutureBuilder<String>(
              future: getAppVersion(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error loading version number');
                } else {
                  String versionNumber = snapshot.data ?? '';
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Version $versionNumber',
                      style: TextStyle(
                        fontSize: AppDimensions.FONT_SIZE_16,
                        color: Constants.DARK_GREY_COLOR,
                      ),
                    ),
                  );
                }
              },
            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Add the version number widget
           
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
