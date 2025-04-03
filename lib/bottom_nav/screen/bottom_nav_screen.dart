import 'dart:async';
import 'dart:ui' as UI;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tqrfamily_bysaz_flutter/my_account/controller/account_controller.dart';
import 'package:tqrfamily_bysaz_flutter/my_account/screen/my_account.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';

import '../../dashboard/controller/dashboard_controller.dart';
import '../../dashboard/screen/dashboard_screen.dart';
import '../../main.dart';
import '../../my_wallet/screen/wallet_screen.dart';
import '../../notification/controller/notification_controller.dart';
import '../../notification/screen/noification_screen.dart';
import '../../poinrequest/controller/point_req_controller.dart';
import '../../res/routes/route_name.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  PersistentTabController? controller;
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;
  var dashboardController = Get.find<DashboardController>();
  var pointsController = Get.find<PointRequestController>();
  var notificationController = Get.find<NotificationController>();
  var accountController = Get.find<AccountController>();
  var deviceKey = box.read('isDistributorLogin') == true
      ? box.read('distributorDevicekey')
      : box.read('retailerDevicekey');

  var passcode = box.read('isDistributorLogin') == true
      ? box.read('distroPassword') : '';

  Stream<int>? _notificationCountStream;
  int notificationCount = 0;
  int statusId = 0;

  List<Widget> buildScreens() {
    return [
      const DashboardScreen(),
      const NotificationScreen(),
      const Sc1(),
      const WalletScreen(),
      const MyAccount(),
    ];
  }

  void dspRetaileCredentialsCheck() {

    if (box.read('isDistributorLogin') == true ) {
       box.remove('retailerName');
    box.remove('retailerPhone');
    } 
    else{
      print('..');
    }
   
  }

  // Future<void> _getDeviceKey() async {
  //   var deviceInfo = DeviceInfoPlugin();

  //   // Get the advertising identifier
  //   AndroidDeviceInfo advertisingIdentifier = await deviceInfo.androidInfo;

  //   // Set the unique device key
  //   _deviceKey = advertisingIdentifier.id;
  //   print('advertising id: $_deviceKey');
  // }

  Future<String?> loadDeviceId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? deviceId = prefs.getString('deviceId');
      print('device IDDD: $deviceId');
      return deviceId;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  void initState() {
    getAppVersion();

    // loadDeviceId().then((value) {
    //   setState(() {
    //   _deviceKey = value ?? ' ';

    //   });

    // });
    // // Future.delayed(Duration(seconds: 3));

    print('device id print $deviceKey');
    controller = PersistentTabController(initialIndex: 0);
    NotificationController.initialize();
    listenNotification();
    print('object');
    startPolling();
    super.initState();
  }

  void startPolling() async {
    const duration =
        Duration(seconds: 120); // Define the polling interval (5 seconds)

    Timer.periodic(duration, (Timer timer) {
      NotificationController()
          .getNotificationCount(deviceKey)
          .then((data) async {
        setState(() {
          notificationCount = data[0]['Count'];
          statusId = data[0]['StatusId'];
        });
        if (notificationCount >= 1 && statusId == 0) {
          await notificationController.refreshNotificationData();
        } else if (statusId == 1) {
          dspRetaileCredentialsCheck();
          Get.offAllNamed(
            RouteName.loginScreen,
          );
          showDialogBox(
              'Session Expired', 'آپ کے سیشن کی معیاد ختم ہو چکی ہے   ');
        } else {}
        print('Notification Count: $notificationCount');
      }).catchError((error) {
        // Handle any errors that occur during the API call
        print('Error: $error');
      });
    });
  }

  Future<void> checkPolling() async {
    print('startPolling()');

    NotificationController()
        .getNotificationCount(deviceKey ?? '')
        .then((data) async {
      setState(() {
        notificationCount = data[0]['Count'];
        statusId = data[0]['StatusId'];
      });
      if (notificationCount > 0 && statusId == 0) {
        await notificationController.refreshNotificationData();
      } else if (statusId == 1) {
        dspRetaileCredentialsCheck();
        
        Get.offAllNamed(
          RouteName.loginScreen,
        );
        showDialogBox(
            'Session Expired', 'آپ کے سیشن کی معیاد ختم ہو چکی ہے   ');
      } else {}

      print('Notification Count: $notificationCount');
    }).catchError((error) {
      // Handle any errors that occur during the API call
      print('Error: $error');
    });
  }

  void listenNotification() => NotificationController.onNotifications.stream
      .listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Get.to(() => NotificationScreen(payload: payload));

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: directionLtr,
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return AlertDialog(
                  title: AppText(
                    text: context.locale.toString() == 'ur'
                        ? '?Are you sure you want to exit'
                        : 'Are you sure you want to exit?',
                    fontSize: 16,
                    fontWeight: FontWeights.bold,
                    color: Constants.BLACK_COLOR,
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
                            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              SystemNavigator.pop();
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
          return false;
        },
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              PersistentTabView(
                context,
                controller: controller,
                screens: buildScreens(),
                items: _navBarsItems(context),
                confineToSafeArea: true,
                onItemSelected: (value) async {
                  if (controller?.index == 1) {
                    notificationController.refresh();
                  }
                  if (controller?.index != 4) {
                  
                    print('hello');
                    await checkPolling();
                  }
                },
                backgroundColor: Colors.white,
                // Default is Colors.white.
                handleAndroidBackButtonPress: true,
                // Default is true.
                resizeToAvoidBottomInset: true,
                // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                stateManagement: true,
                // Default is true.
                hideNavigationBarWhenKeyboardAppears: true,
                // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                decoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  colorBehindNavBar: Colors.white,
                ),

                // popAllScreensOnTapOfSelectedTab: true,
                // popActionScreens: PopActionScreensType.all,
                // itemAnimationProperties: const ItemAnimationProperties(
                //   // Navigation Bar's items animation properties.
                //   duration: Duration(milliseconds: 200),
                //   curve: Curves.ease,
                // ),
                // screenTransitionAnimation: const ScreenTransitionAnimation(
                  // Screen transition animation on change of selected tab.
                //   animateTabTransition: true,
                //   curve: Curves.ease,
                //   duration: Duration(milliseconds: 200),
                // ),
                navBarStyle: NavBarStyle.style16,
                selectedTabScreenContext: (context) {
                  pointsController.dashBRefreshPointRequest();
                  debugPrint('points refreshed');
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    controller?.jumpToTab(0); // Show the dashboard screen
                  },
                  child: Container(
                    width: 80,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Constants.WHITE_COLOR,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 40.w,
                      child: Image.asset(
                        AppImages.TQR_LOGO,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(bottom: 32.w, left: 98.h),
                  child: CircleAvatar(
                    maxRadius: 11,
                    backgroundColor: notificationCount == 0
                        ? Colors.transparent
                        : Constants.SECONDRY_COLOR,
                    child: AppText(
                      text: notificationCount.toString(),
                      color: Constants.WHITE_COLOR,
                      fontSize: AppDimensions.FONT_SIZE_11,
                      fontWeight: FontWeights.bold,
                    ),
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

List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      textStyle: TextStyle(
          fontWeight: FontWeights.medium, fontSize: AppDimensions.FONT_SIZE_12),
    ),
    PersistentBottomNavBarItem(
      // onPressed: (p0) {
      //   NotificationController().refresh();

      // },
      icon: const Icon(Icons.notifications),
      title: ("Notifications"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      textStyle: TextStyle(
          fontWeight: FontWeights.medium, fontSize: AppDimensions.FONT_SIZE_12),
    ),
    PersistentBottomNavBarItem(
      icon: SizedBox(
        height: 52.w,
        child: Image.asset(AppImages.TQR_LOGO),
      ),
      title: ("Tqr"),
      activeColorPrimary: Colors.transparent,
      inactiveColorPrimary: Colors.transparent,
      activeColorSecondary: Colors.transparent,
      textStyle: TextStyle(
          fontWeight: FontWeights.medium,
          fontSize: AppDimensions.FONT_SIZE_12,
          color: Colors.transparent),
    ),
    PersistentBottomNavBarItem(
      // icon: Image.asset(AppImages.NEW_WALLET_ICON,height: 20.w,width: 20,),
      icon: const Icon(
        Icons.account_balance_wallet_outlined,
      ),
      title: ("My Wallet"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      textStyle: TextStyle(
          fontWeight: FontWeights.medium, fontSize: AppDimensions.FONT_SIZE_12),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.person),
      title: ("My Account"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      textStyle: TextStyle(
          fontWeight: FontWeights.medium, fontSize: AppDimensions.FONT_SIZE_12),
    ),
  ];
}

class Sc1 extends StatelessWidget {
  const Sc1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Screen 1',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
