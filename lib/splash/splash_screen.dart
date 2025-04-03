import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tqrfamily_bysaz_flutter/version_check_screen.dart';

import '../main.dart';
import '../res/routes/route_name.dart';
import '../utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  String version = '';

  Future<String?> getAndroidVersion() async {
    String? androidVersion;
    String sanitizedInput = "";
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      androidVersion = androidInfo.version.release;
      List<String> parts = androidVersion.split(".");

      if (parts.length >= 2) {
        sanitizedInput = "${parts[0]}.${parts[1]}";
      } else if (parts.length == 1) {
        sanitizedInput = parts[0];
      }
    } catch (e) {
      // Handle exceptions if necessary
      androidVersion = null;
    }

    return sanitizedInput;
  }

  // var phoneController = Get.put(PhoneController());
  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () {
      box.read('loginUser') == 1
          ? Get.offAllNamed(RouteName.bottomNavScreen)
          : Get.offNamed(
              RouteName.loginScreen,
            );
    });
  }

  Future<String> getVersion() async {
    String sanitizedInput = "";
    PackageInfo? packageInfo;
    try {
      packageInfo = await PackageInfo.fromPlatform();
      List<String> parts = packageInfo.version.split(".");

      if (parts.length >= 2) {
        sanitizedInput = "${parts[0]}.${parts[1]}";
      } else if (parts.length == 1) {
        sanitizedInput = parts[0];
      }
      print('version. no ${packageInfo.version}');
    } on Exception catch (e) {
      // TODO
    }
    print('version. no $sanitizedInput');
    return sanitizedInput;
  }

  Future<void> islogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLogOut', true);
  }

  Future<void> setIsLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasCredentials = prefs.containsKey('isLogOut');

    if (hasCredentials) {
      null;
    } else {
      await prefs.setBool('isLogOut', true);
    }
  }

  Future<bool?> checkIsLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasCredentials = prefs.containsKey('isLogOut');

    if (hasCredentials) {
      bool? credential = prefs.getBool('isLogOut');
      prefs.setBool('isLogOut', false);
      return credential;

    } else {
      return true;
    }
  }



  @override
  void initState() {
    setIsLogout();
    getVersion();
    getAndroidVersion().then((value) async {
      if (value != null) {
        print('android $value');
        if(Platform.isAndroid) {
          if (double.parse(value) > 5.0) {
          String versionNo = await getVersion();
          bool? isLogOut = await checkIsLogout();
          if (isLogOut ?? true) {

            if (double.parse(versionNo) > 1.0) {
              print('Hello boy');
              Get.offNamed(
                RouteName.loginScreen,
              );
            }
            else {
              print('Hello boys');
                controller = AnimationController(vsync: this);
                startTime();
            }
          }
          else {
              print('Hello boys n girls');
            controller = AnimationController(vsync: this);
          startTime();
          }
          
        } else {
          print('android version is old');
          Get.to(() => const VersionCheckScreen());
        }
        }
        else{
           Get.offNamed(
                RouteName.loginScreen,
              );
        }
        
      } else {
        controller = AnimationController(vsync: this);
        startTime();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Lottie.asset(
              'assets/animation/new_splash1.json',
              controller: controller,
              onLoaded: (composition) {
                controller
                  ?..duration = composition.duration
                  ..forward();
              },
              fit: BoxFit.cover,
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
    );
  }
}
