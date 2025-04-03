import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/Fonts/AppDimensions.dart';
import '../utils/Fonts/font_weights.dart';
import '../utils/app_text.dart';
import '../utils/constants.dart';

class HistoryWidget extends StatelessWidget {
  final String? transTxt, status, dateTxt;
  final VoidCallback? onDetailTap;
  const HistoryWidget({Key? key,this.transTxt,this.status,this.onDetailTap,this.dateTxt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 5.h,),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 0.w),
                  child: AppText(
                    text: transTxt??'1',
                    color: Constants.BLACK_COLOR,
                    fontSize: AppDimensions
                        .FONT_SIZE_13,
                    fontWeight:
                    FontWeights.medium,
                    softWrap: true,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: AppText(
                  text: dateTxt??'04-15-2023',
                  color: Constants.BLACK_COLOR,
                  fontSize:
                  AppDimensions.FONT_SIZE_13,
                  fontWeight: FontWeights.medium,
                  softWrap: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: SizedBox(
                  width: 70.w,
                  height: 20.w,
                  child:  ElevatedButton(
                    onPressed: onDetailTap??(){},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Constants.SECONDRY_COLOR),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                    ),
                    child: AppText(
                      text: 'Detail',
                      fontSize: AppDimensions.FONT_SIZE_10,
                      fontWeight: FontWeights.regular,
                      color: Constants.WHITE_COLOR,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            // const Spacer(),
              AppText(
                text: status??'In-Process',
                color: Constants.BLACK_COLOR,
                fontSize: AppDimensions
                    .FONT_SIZE_13,
                fontWeight:
                FontWeights.medium,
              )
            ],
          ),
        ),
        const SizedBox(
          width: double.infinity,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
