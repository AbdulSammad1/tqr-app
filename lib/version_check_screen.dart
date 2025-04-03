import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';

class VersionCheckScreen extends StatelessWidget {
  const VersionCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          
          Column(
            children: [
              SizedBox(height: 150.h,),
              Icon(
                Icons.warning_rounded,
                color: Color.fromARGB(255, 252, 155, 20),
                size: 130.w,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "This App doesn't runs on the android version lower than 5.0",
                    style: TextStyle(color: Constants.BLACK_COLOR, fontSize: 16.h),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
          
          Image.asset('assets/images/tqr_logo.png', height: 160.h, width: 160.h,),
        ],
      )),
    );
  }
}
