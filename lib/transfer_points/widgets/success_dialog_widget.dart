import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';

class SuccessDialog extends StatefulWidget {
  final String receiverNo;
  final String receiverName;
  final String amount;
  final String heading;
  final String city;
  final Function() onTap;

  SuccessDialog(
      {required this.receiverNo,
      required this.receiverName,
      required this.amount,
      required this.heading,
      required this.onTap,
      required this.city});

  @override
  _SuccessDialogState createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  final _screenshotcontroller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotcontroller,
      child: AlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 65.h,
              width: 120.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/tqr_logo.png'),
                      fit: BoxFit.cover)),
              // child: Image.asset('assets/images/tqr_logo.png',  width: 120.h,)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 40,
                  color: Constants.PRIMARY_COLOR,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  widget.heading,
                  style:
                      TextStyle(fontSize: 19, color: Constants.PRIMARY_COLOR),
                )
              ],
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '${DateFormat('dd/MM/yyyy h:mm:ss a').format(DateTime.now())}',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
            SizedBox(
              height: 11,
            ),
            Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Receiver Details: ',
                      style: TextStyle(
                          color: Constants.PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    )),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Shop Name: ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    Expanded(
                      child: Text(
                        widget.receiverName,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      'Mobile No: ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    Expanded(
                      child: Text(
                        widget.receiverNo,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      'City: ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    Expanded(
                      child: Text(
                        widget.city,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 11,
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
                  'Rs.${widget.amount}',
                  style: TextStyle(fontSize: 15, color: Colors.black87),
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
            onPressed: _takeScreenShot,
            child: Text(
              'Share',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Constants.PRIMARY_COLOR,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: widget.onTap,
            child: Text(
              'close',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _takeScreenShot() async {
    final imageFile = await _screenshotcontroller.capture();

    final directory = await getApplicationDocumentsDirectory();

    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(imageFile!);

    await Share.shareFiles([image.path]);

  }
}
