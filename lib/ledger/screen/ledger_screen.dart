import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/common/custome_appbar.dart';
import 'package:tqrfamily_bysaz_flutter/ledger/controller/ledger_controller.dart';

import '../../login/controller/login_controller.dart';
import '../../poinrequest/controller/point_req_controller.dart';
import '../../utils/app_images.dart';
import '../widget/ledger_tabbar.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  var ledgerController = Get.put(LedgerController());
  var loginController = Get.put(LoginController());
  var pointRequestController = Get.put(PointRequestController());
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;

  @override
  void initState() {
    Future.wait([
      ledgerController.thisMonthPointsI(),
      ledgerController.thisMonthPointsO(),
      ledgerController.thisMonthSummary(),
      ledgerController.allTimePointsIn(),
      ledgerController.allTimePointsOut(),
      ledgerController.allSummary(),
      ledgerController.getAlltimeBlnc(),
      ledgerController.getThisMonthBlnc(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        pointRequestController.dashBRefreshPointRequest();
        Get.back();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Directionality(
            textDirection: UI.TextDirection.ltr,
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
                         CustomAppbar(
                          title: 'Ledger',
                          imgPath: AppImages.LEDGER_ICON,
                          buttonWidth:  90.w,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Expanded(
                          child: TabBarPage(),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 90.w,
                    child: Image.asset(AppImages.TQR_LOGO),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

