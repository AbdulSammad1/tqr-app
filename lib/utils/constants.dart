import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Constants {
  static Color PRIMARY_COLOR = const Color(0xff0059AA);
  static Color SECONDRY_COLOR = const Color(0xffc4262f);
  static Color WHITE_COLOR = const Color(0xffffffff);
  static Color BLACK_COLOR = const Color(0xff000000);
  static Color GREY_COLOR = const Color(0xffC5C5C5);
  static Color DARK_GREY_COLOR = const Color(0xff5A5A5A);
  static Color GREEN_COLOR = const Color(0xff007500);
  static Color GREY_COLOR1 = const Color(0xffe8e6e7);
}

bool isBiometric = false;

bool isBrandingNewRequest = true;

bool ispublicityNewRequest = true;

String BrandingScreenMessage =
    'New request ki sahulat bhut jald dastyab hogi zehmat keliye mazraat';

String PublicityScreenMessage =
    'New request ki sahulat bhut jald dastyab hogi zehmat keliye mazraat';

void showDialogBox(String title, String content) {
  showDialog(
    context: Get.context!,
    builder: (ctx) => AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      content: Text(
        content,
        style: TextStyle(color: Colors.black, fontSize: 14.sp),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

void showFunctionDialogBox(BuildContext context, String title, String content,
    Function()? onTap1, Function()? onTap2) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      content: Text(
        content,
        style: const TextStyle(color: Colors.black),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Constants.PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: onTap2,
          child: const Text('No', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Constants.PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: onTap1,
          child: const Text('Yes', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

void showDialogTransferPoints(BuildContext context, String receiverNo, String receiverName,
    String amount, String heading, Function() onTap) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: 40,
            color: Constants.PRIMARY_COLOR,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            heading,
            style: TextStyle(fontSize: 19, color: Constants.PRIMARY_COLOR),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                DateFormat('dd/MM/yyyy h:mm:ss a').format(DateTime.now()),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Column(
            children: [
              const Text('Receiver Details: '),
              Row(
                children: [
                  const Text(
                    'Account No.: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      receiverNo,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'Name: ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                   Expanded(
                    child: Text(
                      receiverName,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Amount: ',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Constants.PRIMARY_COLOR),
              ),
              Text(
                'Rs.$amount',
                style: const TextStyle(fontSize: 15),
              )
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Constants.PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: onTap,
          child: const Text('close'),
        ),
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //       backgroundColor: primaryColor,
        //       shape: RoundedRectangleBorder(
        //           borderRadius:
        //               BorderRadius.circular(20))),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Text('copy'),
        // ),
      ],
    ),
  );
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}
