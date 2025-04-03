import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/points/screen/pending_req.dart';
import 'package:tqrfamily_bysaz_flutter/points/screen/points_history.dart';

import '../../common/custome_appbar.dart';
import '../../poinrequest/controller/point_req_controller.dart';
import '../../utils/app_images.dart';
import '../../utils/card_widget.dart';

class PointsCardScreen extends StatelessWidget {
  const PointsCardScreen({Key? key}) : super(key: key);

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
                       CustomAppbar(title: 'Points',imgPath: AppImages.NEW_WALLET_ICON, buttonWidth: 90.w,),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: Column(
                         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: CardWidget(onTap: (){
                                Get.to(() => const PendingReq());
                              },title: 'Pending Request',
                                imgPath: AppImages.NEW_INPROGRESS_ICON,),
                            ),
                            CardWidget(onTap: (){
                              Get.to(() => const PointsHistory());
                            },title: 'History',imgPath: AppImages.NEW_HISTORY_ICON,),
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
