import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';

import '../../common/custome_appbar.dart';
import '../../poinrequest/controller/point_req_controller.dart';
import '../../res/routes/route_name.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/app_images.dart';
import '../../utils/card_widget.dart';

class BrandingScreen extends StatelessWidget {
  const BrandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var pointRequestController = Get.find<PointRequestController>();
    return WillPopScope(
      onWillPop: () async {
        pointRequestController.refreshPointsMethod();
        Get.back();
        return true;
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                 CustomAppbar(buttonWidth: 90.w,),
                Expanded(
                  child: ListView(
                    children: [
                      CardWidget(
                        onTap: () {
                          Get.toNamed(RouteName.typeScreen);
                        },
                        title: 'Type',
                      ),
                      CardWidget(
                        title: 'New Request',
                        imgPath: AppImages.NEW_REQUEST_ICON,
                        onTap: () {
                          isBrandingNewRequest
                              ? Get.toNamed(RouteName.newBrandReqScreen)
                              : showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Not Available',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: AppDimensions.FONT_SIZE_23),
                                    ),
                                    content: Text(
                                     BrandingScreenMessage,
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
                        },
                      ),
                      CardWidget(
                        title: 'In-Process',
                        imgPath: AppImages.NEW_INPROGRESS_ICON,
                        onTap: () {
                          Get.toNamed(RouteName.inProcessScreen);
                        },
                      ),
                      CardWidget(
                        imgPath: AppImages.NEW_HISTORY_ICON,
                        title: 'History',
                        onTap: () {
                          Get.toNamed(RouteName.bHistoryScreen);
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    AppImages.TQR_LOGO,
                    height: 80.w,
                  ),
                ),
              ],
            ))
          ],
        ),
      )),
    );
  }
}
