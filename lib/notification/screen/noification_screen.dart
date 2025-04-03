import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/main.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/font_weights.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_loader.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_text.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';

import '../../common/custome_appbar.dart';
import '../../pdf_view/screen/pdf_view_screen.dart';
import '../../scheme/controller/scheme_controller.dart';
import '../controller/notification_controller.dart';


class NotificationScreen extends StatefulWidget {
  final String? payload;
  const NotificationScreen({Key? key,this.payload}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with WidgetsBindingObserver {
  var notificationController = Get.find<NotificationController>();

  @override
  void initState() {
    print('hello');
    // notificationController.resetNotificationCount();
    notificationController.getNotificationData();
    WidgetsBinding.instance.addObserver(this);
    notificationController.count.listen((val) {
      // Call a function according to value
    });
    super.initState();
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      notificationController.count.value = 0;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              title:widget.payload ?? 'Notifications',
              color: Colors.transparent,
              width: 0,
              height: 0,
              buttonWidth: 70.w,
              showBackButton: false,
            ),
            Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Obx(() {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        notificationController.notificationModel.isEmpty
                            ? Center(
                          child:notificationController.isLoading.isTrue ?  CircularProgressIndicator(
                            color: Constants.PRIMARY_COLOR,
                          ) :  AppText(text: 'No Notification',color: Constants.BLACK_COLOR,),
                        )
                            : Expanded(
                          child: Scrollbar(
                            controller:
                            notificationController.scrollController,
                            thumbVisibility: true,
                            radius: const Radius.circular(5),
                            thickness: 5,
                            child: ListView.builder(
                                controller:
                                notificationController.scrollController,
                                itemCount: notificationController
                                    .notificationModel.length,
                                shrinkWrap: true,
                                itemBuilder: (context, int index) {
                                  return Directionality(
                                    textDirection: context.locale ==
                                        const Locale('en')
                                        ? directionLtr
                                        : directionLtr,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 40, left: 16, top: 3),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                Colors.transparent,
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(40),
                                                  child: Icon(
                                                    Icons.notifications,
                                                    color: Constants
                                                        .SECONDRY_COLOR,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                fit: FlexFit.loose,
                                                child: InkWell(
                                                  onTap: () async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                      context) {
                                                        return AlertDialog(
                                                          title: AppText(
                                                            text:
                                                            'Notification',
                                                            fontSize:
                                                            AppDimensions
                                                                .FONT_SIZE_16,
                                                            color: Constants
                                                                .PRIMARY_COLOR,
                                                            fontWeight:
                                                            FontWeights
                                                                .medium,
                                                            textDecoration: TextDecoration.underline,
                                                          ),
                                                          scrollable: true,
                                                          titlePadding: const EdgeInsets.only(bottom: 10, left: 22, top: 15),
                                                          content: AppText(
                                                            text:
                                                            '${notificationController.notificationModel[index].notification}',
                                                            fontSize:
                                                            AppDimensions
                                                                .FONT_SIZE_16,
                                                            color: Constants
                                                                .BLACK_COLOR,
                                                            fontWeight:
                                                            FontWeights
                                                                .medium,
                                                            softWrap: true,
                                                          ),
                                                          contentPadding: const EdgeInsets.only(left:25, right: 10, bottom: 5),
                                                          actions: [
                                                            notificationController.notificationModel[index].attachment=='' ? const SizedBox.shrink() :   TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Get.back();
                                                                Future.delayed(const Duration(microseconds: 400),(){
                                                                  appLoader(context, Constants.PRIMARY_COLOR);
                                                                });
                                                                final url = notificationController
                                                                    .notificationModel[
                                                                index]
                                                                    .attachment;
                                                                final file = await PdfApi
                                                                    .loadFromNetwork(
                                                                    url ??
                                                                        '');
                                                                openPdf(file);
                                                              },
                                                              child: Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                                children: [
                                                                  const AppText(
                                                                    text:
                                                                    'Open PDF',
                                                                    fontWeight:
                                                                    FontWeights
                                                                        .medium,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        10),
                                                                    child: Icon(
                                                                      Icons
                                                                          .picture_as_pdf,
                                                                      color: Constants
                                                                          .PRIMARY_COLOR,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(7.0), // Adjust the radius as needed
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 85.h,
                                                    width: 220.w,
                                                    margin:
                                                    const EdgeInsets.only(
                                                        left: 8, right: 16),
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 1,
                                                          blurRadius: 1,
                                                          offset: const Offset(
                                                              0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                    ),
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 12,
                                                        right: 12,
                                                        bottom: 12,
                                                        top: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        AppText(
                                                          text:
                                                          '${notificationController.notificationModel[index].date}',
                                                          fontSize:
                                                          AppDimensions
                                                              .FONT_SIZE_14,
                                                          color: Constants
                                                              .DARK_GREY_COLOR
                                                              .withOpacity(0.5),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                          FontWeights
                                                              .medium,
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10),
                                                            child: AppText(
                                                              text:
                                                              '${notificationController.notificationModel[index].notification}',
                                                              fontSize:
                                                              AppDimensions
                                                                  .FONT_SIZE_14,
                                                              color: Constants
                                                                  .BLACK_COLOR,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              fontWeight:
                                                              FontWeights
                                                                  .medium,
                                                              softWrap: true,
                                                            ),
                                                          ),
                                                        ),
                                                        notificationController.notificationModel[index].attachment=='' ? const SizedBox.shrink() :   GestureDetector(
                                                          onTap: () async {
                                                            appLoader(context, Constants.PRIMARY_COLOR);
                                                            final url =
                                                                notificationController
                                                                    .notificationModel[
                                                                index]
                                                                    .attachment;
                                                            final file =
                                                            await PdfApi
                                                                .loadFromNetwork(
                                                                url ??
                                                                    '');
                                                            openPdf(file);
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                            children: [
                                                               AppText(
                                                                text:
                                                                'Open PDF',
                                                                fontWeight:
                                                                FontWeights
                                                                    .medium,
                                                                fontSize:
                                                                AppDimensions
                                                                    .FONT_SIZE_13,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10),
                                                                child: Icon(
                                                                  Icons
                                                                      .picture_as_pdf,
                                                                  color: Constants
                                                                      .PRIMARY_COLOR,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    );
                  }),
                ))
          ],
        ),
      ),
    );
  }

  void openPdf(File file) {
    Get.back();
    Get.to(() => PdfViewScreen(
      file: file,
    ));
  }
}
