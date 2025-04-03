import 'dart:async';
import 'dart:io';
import 'dart:ui' as UI;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tqrfamily_bysaz_flutter/main.dart';
import 'package:tqrfamily_bysaz_flutter/my_account/controller/account_controller.dart';
import 'package:tqrfamily_bysaz_flutter/points/controller/points_card_controller.dart';
import 'package:tqrfamily_bysaz_flutter/scheme/controller/scheme_controller.dart';
import 'package:tqrfamily_bysaz_flutter/signedScheme/screen/signed_card_screen.dart';
import 'package:tqrfamily_bysaz_flutter/update_checker/screen/update_screen.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_text.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bindings/scheme_binding.dart';
import '../../distributor_login/controller/dsp_login_controller.dart';
import '../../login/controller/login_controller.dart';
import '../../network/controller/network_controller.dart';
import '../../notification/controller/notification_controller.dart';
import '../../notification_services.dart';
import '../../pdf_view/screen/pdf_view_screen.dart';
import '../../poinrequest/controller/point_req_controller.dart';
import '../../res/routes/route_name.dart';
import '../../scheme/screen/scheme_screen.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_loader.dart';
import '../../utils/constants.dart';
import '../../utils/dashboard_bottom_card2.dart';
import '../../utils/dashboard_bottom_card3.dart';
import '../../utils/lang_toggle_btn.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/wallet_card_widget.dart';

typedef WidgetRouteBuilder = Widget Function();

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var dashboardController = Get.find<DashboardController>();
  var loginController = Get.put(LoginController());
  var pointsController = Get.put(PointRequestController());
  final networkController = Get.find<NetworkController>();
  var dspLoginController = Get.put(DspLoginController());
  var notificationController = Get.find<NotificationController>();
  var accountController = Get.find<AccountController>();
  var userNum = box.read('userNumber') ?? '';
  var deviceKey = box.read('isDistributorLogin') == true
      ? box.read('distributorDevicekey')
      : box.read('retailerDevicekey');
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;
  List<Map<String, dynamic>> notifications = [];

  NotificationServices notificationServices = NotificationServices();
  var pointsCardController = Get.put(PointsCardController());

  int notificationCount = 0;
  int statusId = 0;

  bool isLoading = false;

  List<dynamic> sliderImagesList = [].obs;

  AppUpdateInfo? _updateInfo;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool _updateDialogShown = false;

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  void getDeviceId() {
    if (box.read('isDistributorLogin') == true) {
      print('ddd id ${box.read('distributorDevicekey')}');
      // setState(() {
      //   deviceKey = box.read('distributorDevicekey');
      // });
    } else {
      print('ddd id ${box.read('retailerDevicekey')}');
      // setState(() {
      //   deviceKey =  box.read('retailerDevicekey');
      // });
    }
  }

  void dspRetaileCredentialsCheck() {
    if (box.read('isDistributorLogin') == true) {
      box.remove('retailerName');
      box.remove('retailerPhone');
    } else {
      print('..');
    }
  }

  Widget buildLoader() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: CircularProgressIndicator(
            color: Constants.PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  void openPdf(File file) {
    Get.to(() => PdfViewScreen(
          file: file,
        ));
  }

  void getSliderImages() {
    sliderImagesList.clear();
    for (var i = 0; i < dashboardController.imageModelList.length; i++) {
      if (dashboardController.imageModelList[i].sliderUrl.isNotEmpty) {
        sliderImagesList.add(dashboardController.imageModelList[i]);
      }
    }
  }

  Future<String?> loadDeviceId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? deviceId = prefs.getString('deviceId');
      print('device IDDs: $deviceId');

      return deviceId;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> requestNotificationPermissions() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print('alowed');
    } else if (status.isDenied) {
      print("Notification permission is denied.");
    } else {
      print("Permission request failed.");
    }
  }

  void showPromoDialog() {
    dashboardController.imageModelList[0].promotionPopup != ''
        ? showDialog(
            // barrierColor: Colors.white,
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return SizedBox(
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  actionsPadding: EdgeInsets.zero,
                  insetPadding: const EdgeInsets.symmetric(
                      horizontal: 0), // Remove padding around the content
                  contentPadding: EdgeInsets.zero,

                  content: InteractiveViewer(
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () async {
                              if (dashboardController.imageModelList[0].formUrl == 'Scheme' &&
                                  dashboardController.imageModelList[0].status ==
                                      "1") {
                                dashboardController.schemeName1 =
                                    dashboardController
                                        .imageModelList[0].schemeName;
                                Get.toNamed(RouteName.buySchemeScreen,
                                    arguments: dashboardController.schemeName1);
                                logger.i('1');
                              } else if (dashboardController.imageModelList[0].formUrl == 'Scheme' &&
                                  dashboardController.imageModelList[0].status ==
                                      "0") {
                                appLoader(context, Constants.PRIMARY_COLOR);
                                Utils.toastMessage(
                                  'Please wait...',
                                );
                                final url = dashboardController
                                    .imageModelList[0].sliderPath;
                                final file = await PdfApi.loadFromNetwork(url);
                                openPdf(file);
                              } else if (dashboardController.imageModelList[0].formUrl == 'Publicity' &&
                                  dashboardController.imageModelList[0].schemeName ==
                                      'ItemList') {
                                Get.toNamed(RouteName.itemListScreen);
                                //  logger.i('move to item list');
                              } else if (dashboardController.imageModelList[0].formUrl == 'Publicity' &&
                                  dashboardController.imageModelList[0].schemeName ==
                                      'NewRequest') {
                                Get.toNamed(RouteName.pubNewRequestScreen);
                                // logger.i('pub new req');
                              } else if (dashboardController.imageModelList[0].formUrl == 'Publicity' &&
                                  dashboardController.imageModelList[0].schemeName ==
                                      'History') {
                                Get.toNamed(RouteName.pHistoryScreen);
                                // logger.i('pub history');
                              } else if (dashboardController.imageModelList[0].formUrl == 'Publicity' &&
                                  dashboardController.imageModelList[0].schemeName ==
                                      'InProcess') {
                                Get.toNamed(RouteName.pubInProcessScreen);
                                //  logger.i('pub in process');
                              } else if (dashboardController.imageModelList[0].formUrl == 'Branding' &&
                                  dashboardController.imageModelList[0].schemeName ==
                                      'NewRequest') {
                                Get.toNamed(RouteName.newBrandReqScreen);
                                // logger.i('branding new req');
                              } else if (dashboardController.imageModelList[0].formUrl == 'Branding' &&
                                  dashboardController.imageModelList[0].schemeName ==
                                      'History') {
                                Get.toNamed(RouteName.bHistoryScreen);
                                //  logger.i('branding history');
                              } else if (dashboardController.imageModelList[0].formUrl == 'Branding' &&
                                  dashboardController.imageModelList[0].schemeName ==
                                      'InProcess') {
                                Get.toNamed(RouteName.inProcessScreen);
                                // logger.i('branding in process');
                              } else if (dashboardController.imageModelList[0].formUrl == 'Branding' &&
                                  dashboardController.imageModelList[0].schemeName == 'Type') {
                                Get.toNamed(RouteName.typeScreen);
                                // logger.i('branding type');
                              }
                            },
                            child: Container(
                              width: 380,
                              height: 375,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      dashboardController
                                          .imageModelList[0].promotionPopup,
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            )
                            //                 Container(
                            //   decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //           image: NetworkImage(
                            //             dashboardController
                            //                 .imageModelList[0].promotionPopup,
                            //           ),
                            //           fit: BoxFit.contain),
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(20.w)),
                            //   height: 250.h,
                            //   alignment: Alignment.center,
                            //   // child: Image.network(
                            //   //   dashboardController.imageModelList[0].promotionPopup,
                            //   //   fit: BoxFit.cover,
                            //   //   errorBuilder: (context, error, stackTrace) {
                            //   //     return const Center(child: Text('No Promotion Found'),);
                            //   //   }
                            //   // ),
                            // ),
                            ),
                        Positioned(
                            top: 4.h,
                            right: 3.w,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  CupertinoIcons.xmark_octagon_fill,
                                  size: 40.w,
                                  color: Colors.red,
                                )))
                      ],
                    ),
                  ),
                ),
              );
            })
        : print('no image');
  }

  Future<void> checkPolling() async {
    print('startPolling() $deviceKey');

    NotificationController().getNotificationCount(deviceKey).then((data) async {
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

  @override
  void initState() {
    super.initState();

    requestNotificationPermissions();

    print('dashboard Device Id $deviceKey');

    checkPolling();

    initFunctions();

    getDeviceId();

    checkForUpdate();
    notificationServices.firebaseInit(context);

    // notificationServices.setupInteractMessage(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    notificationController.dispose();
  }

  void distroPasswordCheck() {
    DspLoginController().passwordCheck().then((value) {
      print('value is $value');
      if (value == 0) {
        // dspRetaileCredentialsCheck();
        Get.offAllNamed(
          RouteName.loginScreen,
        );

        showDialogBox(
            'Session Expired', 'آپ کے سیشن کی معیاد ختم ہو چکی ہے   ');
      } else {
        print('valid');
      }
    });
  }

  void initFunctions() async {
    box.read('isDistributorLogin') == true
        ? distroPasswordCheck()
        : print('hello');
    await pointsCardController.refreshDataPendingPoints();
    await dashboardController.getSliderImages().then((value) {
      getSliderImages();
      showPromoDialog();
    });

    await dashboardController.getUserName();
  }

  Future<void> checkForUpdate() async {
    try {
      setState(() {
        isLoading = true;
      });
      _updateInfo = await InAppUpdate.checkForUpdate();

      // Check if an update is available and the update dialog hasn't been shown yet
      if (_updateInfo?.updateAvailability ==
              UpdateAvailability.updateAvailable &&
          !_updateDialogShown) {
        setState(() {
          isLoading = false;
        });
        Get.to(() => UpdateScreen());
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnack(e.toString());
    }
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  // Method to show the update message dialog
  void _showUpdateDialog() {
    if (_updateInfo != null &&
        _updateInfo!.updateAvailability == UpdateAvailability.updateAvailable) {
      _updateDialogShown = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text(
            'Update Available',
            style: TextStyle(color: Colors.black),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'A new version is available',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 8),
              Text(
                'New Version: ${_updateInfo!.availableVersionCode}',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _launchAppStore();
              },
              child: const Text('Update Now'),
            ),
          ],
        ),
      );
    }
  }

  void _launchAppStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.sazent.tqrfamily';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showSnack('Could not open the Play Store');
    }
  }

  Future<void> _authenticate() async {
    bool isAuthenticated = false;

    try {
      if (await _localAuthentication.canCheckBiometrics) {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
        );
      }
    } catch (e) {
      print(e);
    }

    if (isAuthenticated) {
      Get.toNamed(RouteName.transferPointsScreen);
    } else {
      await _showPinAuthentication();
    }
  }

  Future<void> _showPinAuthentication() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'PIN Code Authentication',
          style: TextStyle(
              color: Colors.black, fontSize: AppDimensions.FONT_SIZE_21),
        ),
        content: PinCodeTextField(
          textStyle: const TextStyle(color: Colors.black),
          showCursor: false,
          appContext: context,
          length: 4,
          onChanged: (value) {
            // Handle PIN code changes
          },
          onCompleted: (value) {
            if (value == '1234') {
              Navigator.pop(context);
              Get.toNamed(RouteName.transferPointsScreen);
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Invalid PIN',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: AppDimensions.FONT_SIZE_23),
                  ),
                  content: Text(
                    'The entered PIN is incorrect.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: AppDimensions.FONT_SIZE_15),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              edgeOffset: 10,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 1), () {
                  Future.wait(
                    [
                      dashboardController.getSliderImages().then((value) {
                        getSliderImages();
                      }),
                      dashboardController.getUserName(),
                      pointsController.dashBRefreshPointRequest(),
                      pointsCardController.refreshDataPendingPoints(),
                    ],
                  )
                      .then((value) => {
                            if (networkController.connectionStatus.value == 1)
                              {
                                Utils.appSnackBar(
                                    title: 'Success',
                                    subtitle: 'Refreshed Successfully',
                                    bgColor: Constants.PRIMARY_COLOR
                                        .withOpacity(0.8)),
                              }
                            else
                              {
                                Utils.appSnackBar(
                                  title: 'Alert',
                                  subtitle:
                                      'Make sure you are connected to internet',
                                ),
                              }
                          })
                      .onError((error, stackTrace) => {
                            Utils.appSnackBar(
                              title: 'Alert',
                              subtitle: 'Refresh Failed',
                            ),
                          });
                });
              },
              child: Column(
                children: [
                  Column(
                    children: [
                      //AppBar
                      Container(
                        width: double.infinity,
                        height: 70.w,
                        decoration: BoxDecoration(
                          color: Constants.PRIMARY_COLOR,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Obx(() {
                          return Directionality(
                            textDirection: directionLtr,
                            child: ListTile(
                              leading: SvgPicture.asset(
                                AppImages.USER_PROFILE_ICON,
                                height: 40.w,
                                width: 40.w,
                                color: Constants.WHITE_COLOR,
                              ),
                              title: AppText(
                                text:
                                    networkController.connectionStatus.value ==
                                            1
                                        ? dashboardController.userName.value
                                        : 'No Internet Connection',
                                fontSize: AppDimensions.FONT_SIZE_13,
                                fontWeight: FontWeights.bold,
                                color: Constants.WHITE_COLOR,
                                overflow: TextOverflow.ellipsis,
                                textAlign: context.locale.toString() == 'ur'
                                    ? TextAlign.start
                                    : TextAlign.start,
                              ),
                              subtitle: AppText(
                                text: '92${userNum.replaceFirst('92', '')}',
                                fontSize: AppDimensions.FONT_SIZE_13,
                                fontWeight: FontWeights.bold,
                                color: Constants.WHITE_COLOR,
                                textAlign: context.locale.toString() == 'ur'
                                    ? TextAlign.start
                                    : TextAlign.start,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 9.w,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // retailer login codec( Usman ) start
                                  box.read('adminNum') == null
                                      ? const SizedBox.shrink()
                                      : GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                RouteName.dspRetailerLogin);
                                          },
                                          child: Icon(
                                            Icons.more_vert,
                                            color: Constants.WHITE_COLOR,
                                          ),
                                        ),
                                  GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        return Future.delayed(
                                            const Duration(seconds: 1), () {
                                          Future.wait(
                                            [
                                               dashboardController.getSliderImages().then((value) {
                        getSliderImages();
                      }),
                                              dashboardController.getUserName(),
                                              pointsController
                                                  .dashBRefreshPointRequest(),
                                              accountController
                                                  .getUserDetails(),
                                              pointsCardController
                                                  .refreshDataPendingPoints(),
                                            ],
                                          )
                                              .then((value) => {
                                                    setState(() {
                                                      isLoading =
                                                          false; // Show the loader
                                                    }),
                                                    if (networkController
                                                            .connectionStatus
                                                            .value ==
                                                        1)
                                                      {
                                                        Utils.appSnackBar(
                                                            title: 'Success',
                                                            subtitle:
                                                                'Refreshed Successfully',
                                                            bgColor: Constants
                                                                .PRIMARY_COLOR
                                                                .withOpacity(
                                                                    0.8)),
                                                        showPromoDialog(),
                                                      }
                                                    else
                                                      {
                                                        Utils.appSnackBar(
                                                          title: 'Alert',
                                                          subtitle:
                                                              'Make sure you are connected to internet',
                                                        ),
                                                      }
                                                  })
                                              .onError((error, stackTrace) => {
                                                    Utils.appSnackBar(
                                                      title: 'Alert',
                                                      subtitle:
                                                          'Refresh Failed',
                                                    ),
                                                  });
                                        });
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0,
                                            top: 0,
                                            bottom: 0,
                                            right: 10),
                                        child: Icon(
                                          Icons.refresh,
                                          color: Colors.white,
                                        ),
                                      )),
                                  // retailer login codec( Usman ) end
                                  SizedBox(
                                    width: 82.w,
                                    height: 30.w,
                                    child: LangToggleBtn(
                                      status: loginController.status.value,
                                      onToggle: (val) {
                                        if (context.locale.toString() == 'ur') {
                                          context.setLocale(
                                            const Locale('en'),
                                          );
                                          Get.updateLocale(const Locale('en'));
                                          loginController.toggleLanguage(val);
                                        } else {
                                          context.setLocale(
                                            const Locale('ur'),
                                          );
                                          Get.updateLocale(const Locale('ur'));
                                          loginController.toggleLanguage(val);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),

                      Directionality(
                        textDirection: directionLtr,
                        child: CarouselSlider.builder(
                          itemCount: sliderImagesList.length,
                          carouselController:
                              dashboardController.carouselController,
                          itemBuilder: (context, index, realIndex) {
                            return sliderImagesList.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Card(
                                    elevation:
                                        10, // Adjust the elevation as per your preference
                                    child: GestureDetector(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10.w),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              '${sliderImagesList[index].sliderUrl}',
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        width: 300.w,
                                      ),
                                      onTap: () async {
                                        if (sliderImagesList[index].formUrl == 'Scheme' &&
                                            sliderImagesList[index].status ==
                                                "1") {
                                          dashboardController.schemeName1 =
                                              dashboardController
                                                  .imageModelList[index]
                                                  .schemeName;
                                          Get.toNamed(RouteName.buySchemeScreen,
                                              arguments: dashboardController
                                                  .schemeName1);
                                          logger.i('1');
                                        } else if (sliderImagesList[index].formUrl == 'Scheme' &&
                                            sliderImagesList[index].status ==
                                                "0") {
                                          appLoader(
                                              context, Constants.PRIMARY_COLOR);
                                          Utils.toastMessage(
                                            'Please wait...',
                                          );
                                          final url = sliderImagesList[index]
                                              .sliderPath;
                                          final file =
                                              await PdfApi.loadFromNetwork(url);
                                          openPdf(file);
                                        } else if (sliderImagesList[index].formUrl == 'Publicity' &&
                                            sliderImagesList[index].schemeName ==
                                                'ItemList') {
                                          Get.toNamed(RouteName.itemListScreen);
                                          //  logger.i('move to item list');
                                        } else if (sliderImagesList[index].formUrl == 'Publicity' &&
                                            sliderImagesList[index].schemeName ==
                                                'NewRequest') {
                                          Get.toNamed(
                                              RouteName.pubNewRequestScreen);
                                          // logger.i('pub new req');
                                        } else if (sliderImagesList[index].formUrl == 'Publicity' &&
                                            sliderImagesList[index].schemeName ==
                                                'History') {
                                          Get.toNamed(RouteName.pHistoryScreen);
                                          // logger.i('pub history');
                                        } else if (sliderImagesList[index].formUrl ==
                                                'Publicity' &&
                                            sliderImagesList[index].schemeName ==
                                                'InProcess') {
                                          Get.toNamed(
                                              RouteName.pubInProcessScreen);
                                          //  logger.i('pub in process');
                                        } else if (sliderImagesList[index].formUrl == 'Branding' &&
                                            sliderImagesList[index].schemeName ==
                                                'NewRequest') {
                                          Get.toNamed(
                                              RouteName.newBrandReqScreen);
                                          // logger.i('branding new req');
                                        } else if (sliderImagesList[index].formUrl == 'Branding' &&
                                            sliderImagesList[index].schemeName ==
                                                'History') {
                                          Get.toNamed(RouteName.bHistoryScreen);
                                          //  logger.i('branding history');
                                        } else if (sliderImagesList[index].formUrl == 'Branding' &&
                                            sliderImagesList[index].schemeName ==
                                                'InProcess') {
                                          Get.toNamed(
                                              RouteName.inProcessScreen);
                                          // logger.i('branding in process');
                                        } else if (sliderImagesList[index].formUrl == 'Branding' &&
                                            sliderImagesList[index].schemeName == 'Type') {
                                          Get.toNamed(RouteName.typeScreen);
                                          // logger.i('branding type');
                                        }
                                      },
                                    ),
                                  );
                          },
                          options: CarouselOptions(
                            height: 120.h,
                            autoPlay:
                                dashboardController.imageModelList.length == 1
                                    ? false
                                    : true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            reverse: false,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                dashboardController.current = index;
                              });
                            },
                          ),
                        ),
                      ),
                      //indicator
                      Obx(() {
                        return Directionality(
                          textDirection: directionLtr,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: sliderImagesList.map((url) {
                              int index = sliderImagesList.indexOf(url);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: dashboardController.current == index
                                      ? Constants.SECONDRY_COLOR
                                      : Constants.GREY_COLOR,
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                      GetBuilder<PointRequestController>(builder: (logic) {
                        return NewWalletCard(
                          onTapGetPoints: () async {
                            await checkPolling();
                            Get.toNamed(RouteName.pointRequestScreen);
                          },
                          onTapLedger: () async {
                            await checkPolling();
                            Get.toNamed(RouteName.ledgerScreen);
                          },
                          onTapRefresh: () {
                            Future.delayed(const Duration(microseconds: 600),
                                () {
                              appLoader(context, Constants.PRIMARY_COLOR);
                              pointsController.dashBRefreshPointRequest();
                            });
                          },
                          pointsTxt: logic.val ?? '0',
                          onTapTransferPoints: () {
                            isBiometric
                                ? _authenticate()
                                : Get.toNamed(RouteName.transferPointsScreen);
                          },
                        );
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //scheme card
                                NewDashBottomCard(
                                  onTap: () async {
                                    await checkPolling();
                                    Get.to(() => const SchemeScreen(),
                                        binding: SchemeBinding());
                                  },
                                ),
                                //branding card
                                NewDashBottomCard(
                                  title: 'Branding',
                                  imPath: AppImages.NEW_BRANDING_ICON,
                                  onTap: () async {
                                    await checkPolling();
                                    Get.toNamed(RouteName.brandingScreen);
                                  },
                                ),
                                //publicity card
                                NewDashBottomCard(
                                    title: 'Publicity',
                                    imPath: AppImages.NEW_PUBLICTY_ICON,
                                    onTap: () async {
                                      await checkPolling();
                                      Get.toNamed(RouteName.publicityScreen);
                                    }),
                              ],
                            ),
                            box.read('dotBtn') == true
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 22.w,
                                      ),
                                      //scheme card
                                      NewDashBottomCard(
                                        title: 'Signed Scheme',
                                        onTap: () async {
                                          await checkPolling();
                                          Get.toNamed(
                                              SignedSchemeCardScreen.routeName);
                                        },
                                      ),
                                      SizedBox(
                                        width: 22.w,
                                      ),
                                      NewDashBottomCard3(
                                        title: 'Points',
                                        imPath: AppImages.NEW_WALLET_ICON,
                                        isNew: pointsCardController
                                                .pendingPointModel.isEmpty
                                            ? false
                                            : true,
                                        badgetext: pointsCardController
                                            .pendingPointModel.length
                                            .toString(),
                                        onTap: () async {
                                          await checkPolling();
                                          Get.toNamed(
                                              RouteName.pointsCardScreen);
                                        },
                                      ),

                                      // SizedBox(
                                      //   height: 110.w,
                                      //   width:  105.w,
                                      // )
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(
                              height: 30.w,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (isLoading) buildLoader(),
      ],
    );
  }
}
