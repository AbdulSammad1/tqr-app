import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/signedScheme/screen/history_screen.dart';
import 'package:tqrfamily_bysaz_flutter/signedScheme/screen/signed_screen.dart';

import '../../common/custome_appbar.dart';
import '../../utils/app_images.dart';
import '../../utils/card_widget.dart';

class SignedSchemeCardScreen extends StatefulWidget {

  static const routeName = '/signed-scheme-card';

  const SignedSchemeCardScreen({Key? key}) : super(key: key);

  @override
  State<SignedSchemeCardScreen> createState() => _SignedSchemeCardScreenState();
}

class _SignedSchemeCardScreenState extends State<SignedSchemeCardScreen> {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
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
                       CustomAppbar(title: 'Signed Scheme',imgPath: null, buttonWidth:  50.w,),
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
                                Get.to(() => const SignedSchScreen());
                              },title: 'In Process',
                                imgPath: AppImages.NEW_INPROGRESS_ICON,),
                            ),
                            CardWidget(onTap: (){
                              Get.to(() => const HistoryScreen());
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
