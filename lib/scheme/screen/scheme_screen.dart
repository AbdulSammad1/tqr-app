import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/common/custome_appbar.dart';

import '../../poinrequest/controller/point_req_controller.dart';
import '../../res/routes/route_name.dart';
import '../../utils/app_images.dart';
import '../../utils/dashboard_bottom_card2.dart';

class SchemeScreen extends StatelessWidget {
  const SchemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pointRequestController = Get.put(PointRequestController());
    return WillPopScope(
      onWillPop: ()async{
        pointRequestController.refreshPointsMethod();
        Get.back();
        return true;
      },
      child: Scaffold(
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
                      //scheme image
                      CustomAppbar(title: 'Scheme',imgPath: AppImages.NEW_SCHEME_ICON, buttonWidth: 80.w,),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DashboardBottomCard2(
                              onTap: () {
                                Get.toNamed(RouteName.buySchemeScreen, );
                              },
                              imagePath: AppImages.NEW_BUY_ICON,
                              imgHeight: 10.w,
                              cardWidth: 90.w,
                              cardHeight: 80.h,
                              imgPadding: 14,
                              isTitle: true,
                              isSubTitle: false,
                              title: 'Buy',
                            ),
                            DashboardBottomCard2(
                              onTap: () {
                                Get.toNamed(RouteName.scInProcessScreen,);
                              },
                              imagePath: AppImages.NEW_INPROGRESS_ICON,
                              imgHeight: 10.w,
                              cardWidth: 90.w,
                              cardHeight: 80.h,
                              imgPadding: 14,
                              isTitle: true,
                              isSubTitle: false,
                              title: 'In-Process',
                            ),
                            DashboardBottomCard2(
                              onTap: () {
                                Get.toNamed(RouteName.schemeHistoryScreen,);
                              },
                              imagePath: AppImages.NEW_HISTORY_ICON,
                              imgHeight: 10.w,
                              cardWidth: 90.w,
                              cardHeight: 80.h,
                              imgPadding: 15,
                              isTitle: true,
                              isSubTitle: false,
                              title: 'History',
                            ),
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
      ),
    );
  }
}
