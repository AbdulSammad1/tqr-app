import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';

class TableWidget extends StatelessWidget {
  final String? transTxt, dateTxt, status;
  final VoidCallback? onDetailTap;
  const TableWidget({Key? key,this.transTxt,this.dateTxt,this.status,this.onDetailTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: 5.h,),
            child: Row(
              children: [
                Expanded(
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: AppText(
                      text: dateTxt??'04-15-2023',
                      color: Constants.BLACK_COLOR,
                      fontSize:
                      AppDimensions.FONT_SIZE_13,
                      fontWeight: FontWeights.medium,
                      softWrap: true,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: SizedBox(
                      width: 70.w,
                      height: 20.w,
                      child:  ElevatedButton(
                        onPressed:onDetailTap?? (){},
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
                ),
                Expanded(
                  child: AppText(
                    text: status??'In-Process',
                    color: Constants.BLACK_COLOR,
                    fontSize: AppDimensions
                        .FONT_SIZE_13,
                    fontWeight:
                    FontWeights.medium,
                    textAlign: TextAlign.end,

                  ),
                )
              ],
            ),
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
