import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/ledger/controller/ledger_controller.dart';

import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../widget/open_balance_widget.dart';
import 'list_tile_widget.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var ledgerController = Get.find<LedgerController>();

  @override
  void initState() {
    tabController = TabController(
        length: 2, vsync: this, initialIndex: ledgerController.tabIndex.value);

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Column(
          children: [
            Container(
              height: 55.w,
              width: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: BoxDecoration(
                color: Constants.GREY_COLOR1,
              ),
              alignment: Alignment.center,
              child: TabBar(
                
                unselectedLabelColor: Constants.BLACK_COLOR,
                indicatorWeight: 23.h,
                indicatorPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                automaticIndicatorColorAdjustment: true,
                labelColor: Constants.WHITE_COLOR,
                indicator: BoxDecoration(
                  color: Constants.PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                isScrollable: false,
                controller: tabController,
                labelStyle:  TextStyle(
                  fontSize: AppDimensions.FONT_SIZE_16,
                  fontWeight: FontWeights.semiBold,
                ),
                tabs: [
                  Padding(
                    padding: EdgeInsets.only(top: 14.h, left: 60.w, right: 60),
                    child:  Text('All Time', style: TextStyle(fontSize: 13.sp),).tr(),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Text('This Month', style: TextStyle(fontSize: 13.sp)).tr()),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  AllTimeTab(),
                  ThisMonthTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AllTimeTab extends StatefulWidget {
  const AllTimeTab({super.key});

  @override
  State<AllTimeTab> createState() => _AllTimeTabState();
}

class _AllTimeTabState extends State<AllTimeTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var ledgerController = Get.put(LedgerController());

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 350.h,
                  child: Column(
                    children: [
                      //add tabs here
                      Container(
                        height: 40.w,
                        width:double.infinity,
                        decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: Constants.GREY_COLOR,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: TabBar(
                          
                          unselectedLabelColor: Constants.BLACK_COLOR,
                          indicatorWeight:
                          context.locale.toString() == 'en' ? 17 : 10,
                          labelColor: Constants.WHITE_COLOR,
                          indicator: BoxDecoration(
                            color: Constants.PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          padding: EdgeInsets.zero,
                           indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: EdgeInsets.zero,
                          isScrollable: false,
                          controller: tabController,
                          automaticIndicatorColorAdjustment: true,
                          labelStyle:  TextStyle(
                            fontSize: AppDimensions.FONT_SIZE_14,
                            fontWeight: FontWeights.regular,
                          ),
                          tabs: [
                            Padding(
                              //padding: EdgeInsets.only(top: 10.h),
                              padding: EdgeInsets.only(
                                  top: 10.h, left: 30, right: 30),
                              child:  Text('POINTS IN', style: TextStyle(fontSize: 12.sp)).tr(),
                            ),
                            Padding(
                              //padding: EdgeInsets.only(top: 10.h),
                              padding: EdgeInsets.only(
                                  top: 10.h, left: 30, right: 30),
                              child:  Text('POINTS OUT', style: TextStyle(fontSize: 12.sp)).tr(),
                            ),
                            Padding(
                              //padding: EdgeInsets.only(top: 10.h),
                              padding: EdgeInsets.only(
                                  top: 10.h, left: 30, right: 30),
                              child:  Text('SUMMARY', style: TextStyle(fontSize: 12.sp)).tr(),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              //ponits TAB
                              Scrollbar(
                                controller: ledgerController.scrollController,
                                thumbVisibility: true,
                                interactive: true,
                                radius: const Radius.circular(5),
                                thickness: 5,
                                child: ListView(
                                  controller: ledgerController.scrollController,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, left: 0.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          const PointsInTab(),
                                          Divider(
                                            color: Constants.GREY_COLOR,
                                            thickness: 1,
                                          ),
                                          ledgerController.pointsInModel
                                              .isEmpty ==
                                              true
                                              ? Center(
                                              child: ledgerController.isLoading
                                                  .isTrue
                                                  ? CircularProgressIndicator(
                                                color: Constants.PRIMARY_COLOR,)
                                                  : AppText(text: 'No Data Found',
                                                color: Constants.PRIMARY_COLOR,))
                                              : ListView.builder(
                                            itemCount: ledgerController
                                                .pointsInModel.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, int index) {
                                              return Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .pointsInModel[index]
                                                                .date}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex:2,
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .pointsInModel[index]
                                                                .description}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                            softWrap: true,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .pointsInModel[index]
                                                                .amount}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: Constants.GREY_COLOR,
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //pointsOutTab
                              Scrollbar(
                                controller: ledgerController.scrollController2,
                                thumbVisibility: true,
                                radius: const Radius.circular(5),
                                thickness: 5,
                                child: ListView(
                                  controller: ledgerController
                                      .scrollController2,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, left: 0.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          const PointsOutTab(),
                                          Divider(
                                            color: Constants.GREY_COLOR,
                                            thickness: 1,
                                          ),
                                          ListView.builder(
                                            itemCount: ledgerController
                                                .pointsOutModel.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, int index) {
                                              return Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .pointsOutModel[index]
                                                                .date}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex:2,
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .pointsOutModel[index]
                                                                .description}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                            softWrap: true,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .pointsOutModel[index]
                                                                .amount}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: Constants.GREY_COLOR,
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                            physics: const NeverScrollableScrollPhysics(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //summaryTab
                              Scrollbar(
                                controller: ledgerController.scrollController3,
                                thumbVisibility: true,
                                radius: const Radius.circular(5),
                                thickness: 5,
                                child: ListView(
                                  controller: ledgerController
                                      .scrollController3,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, left: 0.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          ListView.builder(
                                              itemCount: ledgerController
                                                  .summaryModel.length,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context,
                                                  int index) {
                                                return Column(
                                                  children: [
                                                    ListTileWidget(
                                                      subTitleText:
                                                      '${ledgerController
                                                          .summaryModel[index]
                                                          .totalPointsIn??0}',
                                                    ),
                                                    ListTileWidget(
                                                      titleText: 'Total Points Out',
                                                      subTitleText:
                                                      '${ledgerController
                                                          .summaryModel[index]
                                                          .totalPointsOut??0}',
                                                      arrowDownWidget: Image.asset(
                                                        AppImages.ARROW_DOWN_ICON,
                                                        height: 30.w,
                                                        width: 30.w,

                                                      ),
                                                    ),
                                                    ListTileWidget(
                                                      titleText: 'Total Balance Points',
                                                      subTitleText:
                                                      '${ledgerController
                                                          .summaryModel[index]
                                                          .totalBalancePoints??0}',
                                                    ),

                                                  ],
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              //const Spacer(),
              context.locale.toString() == 'en'
                  ? Obx(() {
                return openBalanceEng(
                    ledgerController.allTimeOBlnc.value,
                    ledgerController.allTimeCBlnc.value);
              })
                  : Obx(() {
                return openBalanceUr(
                    ledgerController.allTimeOBlnc.value,
                    ledgerController.allTimeCBlnc.value);
              }),
            ],
          )),
    );
  }
}

class ThisMonthTab extends StatefulWidget {
  const ThisMonthTab({super.key});

  @override
  State<ThisMonthTab> createState() => _ThisMonthTabState();
}

class _ThisMonthTabState extends State<ThisMonthTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var ledgerController = Get.find<LedgerController>();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 350.h,
                  child: Column(
                    children: [
                      //add tabs here
                      Container(
                        height: 40.w,
                        width: MediaQuery
                            .of(context)
                            .size
                            .height,
                        decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: Constants.GREY_COLOR,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: TabBar(
                          unselectedLabelColor: Constants.BLACK_COLOR,
                          indicatorWeight:
                          context.locale.toString() == 'en' ? 14 : 10,
                          labelColor: Constants.WHITE_COLOR,
                          indicator: BoxDecoration(
                            color: Constants.PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          isScrollable: false,
                          controller: tabController,
                          indicatorPadding: EdgeInsets.zero,
                          automaticIndicatorColorAdjustment: true,
                          labelStyle:  TextStyle(
                            fontSize: AppDimensions.FONT_SIZE_14,
                            fontWeight: FontWeights.regular,
                          ),
                          tabs: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.h, left: 30, right: 30),
                              child:  Text('POINTS IN', style: TextStyle(fontSize: 12.sp)).tr(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.h, left: 30, right: 30),
                              child:  Text('POINTS OUT', style: TextStyle(fontSize: 12.sp)).tr(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.h, left: 30, right: 30),
                              child:  Text('SUMMARY', style: TextStyle(fontSize: 12.sp)).tr(),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              //points TAB
                              Scrollbar(
                                controller: ledgerController.scrollController4,
                                thumbVisibility: true,
                                radius: const Radius.circular(5),
                                thickness: 5,
                                child: ListView(
                                  controller: ledgerController
                                      .scrollController4,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, left: 0.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          const PointsInTab(),
                                          Divider(
                                            color: Constants.GREY_COLOR,
                                            thickness: 1,
                                          ),
                                          ledgerController
                                              .points_in_tmModel.isEmpty ==
                                              true
                                              ?  Center(
                                              child:ledgerController.isLoading.isTrue? CircularProgressIndicator(color: Constants.PRIMARY_COLOR,):
                                          AppText(text: 'No Data Found',color: Constants.BLACK_COLOR,))
                                              : ListView.builder(
                                            itemCount: ledgerController
                                                .points_in_tmModel.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, int index) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .points_in_tmModel[index]
                                                                .date}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex:2,
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .points_in_tmModel[index]
                                                                .description}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                            softWrap: true,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .points_in_tmModel[index]
                                                                .amount}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: Constants.GREY_COLOR,
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //pointsOutTab
                              Scrollbar(
                                controller: ledgerController.scrollController5,
                                thumbVisibility: true,
                                radius: const Radius.circular(5),
                                thickness: 5,
                                child: ListView(
                                  controller: ledgerController
                                      .scrollController5,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, left: 0.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          const PointsOutTab(),
                                          Divider(
                                            color: Constants.GREY_COLOR,
                                            thickness: 1,
                                          ),
                                          ListView.builder(
                                            itemCount: ledgerController
                                                .points_out_tmModel.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, int index) {
                                              return Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .points_out_tmModel[index]
                                                                .date}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex:2,
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .points_out_tmModel[index]
                                                                .description}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                            softWrap: true,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: AppText(
                                                            text:
                                                            '${ledgerController
                                                                .points_out_tmModel[index]
                                                                .amount}',
                                                            fontSize: AppDimensions
                                                                .FONT_SIZE_14.sp,
                                                            fontWeight:
                                                            FontWeights.regular,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: Constants.GREY_COLOR,
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //summaryTab
                              Scrollbar(
                                controller: ledgerController.scrollController6,
                                thumbVisibility: true,
                                radius: const Radius.circular(5),
                                thickness: 5,
                                child: ListView(
                                  controller: ledgerController
                                      .scrollController6,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, left: 0.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          ListView.builder(
                                              itemCount: ledgerController
                                                  .points_summary_tmModel
                                                  .length,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context,
                                                  int index) {
                                                return Column(
                                                  children: [
                                                    ListTileWidget(
                                                      subTitleText:
                                                      '${ledgerController
                                                          .points_summary_tmModel[index]
                                                          .totalPointsIn??0}',
                                                    ),
                                                    ListTileWidget(
                                                      titleText: 'Total Points Out',
                                                      subTitleText:
                                                      '${ledgerController
                                                          .points_summary_tmModel[index]
                                                          .totalPointsOut??0}',
                                                      arrowDownWidget: Image.asset(
                                                        AppImages.ARROW_DOWN_ICON,
                                                        height: 30.w,
                                                        width: 30.w,
                                                      ),
                                                    ),
                                                    ListTileWidget(
                                                      titleText: 'Total Balance Points',
                                                      subTitleText:
                                                      '${ledgerController
                                                          .points_summary_tmModel[index]
                                                          .totalBalancePoints??0}',
                                                    ),
                                                  ],
                                                );
                                              })
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              context.locale.toString() == 'en'
                  ? Obx(() {
                return openBalanceEng(
                    ledgerController.thisMonthOBlnc.value,
                    ledgerController.thisMonthCBlnc.value);
              })
                  : Obx(() {
                return openBalanceUr(
                    ledgerController.thisMonthOBlnc.value,
                    ledgerController.thisMonthCBlnc.value);
              }),
            ],
          )),
    );
  }
}



class PointsInTab extends StatelessWidget {
  const PointsInTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AppText(
          text: 'Date',
          fontSize: AppDimensions.FONT_SIZE_14.sp,
          fontWeight: FontWeights.regular,
        ),
        AppText(
          text: 'Distributor',
          fontSize: AppDimensions.FONT_SIZE_14.sp,
          fontWeight: FontWeights.regular,
        ),
        AppText(
          text: 'Pts',
          fontSize: AppDimensions.FONT_SIZE_14.sp,
          fontWeight: FontWeights.regular,
        ),
      ],
    );
  }
}

class PointsOutTab extends StatelessWidget {
  const PointsOutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AppText(
          text: 'Date',
          fontSize: AppDimensions.FONT_SIZE_14.sp,
          fontWeight: FontWeights.regular,
        ),
        AppText(
          text: 'Description',
          fontSize: AppDimensions.FONT_SIZE_14.sp,
          fontWeight: FontWeights.regular,
        ),
        AppText(
          text: 'Pts',
          fontSize: AppDimensions.FONT_SIZE_14.sp,
          fontWeight: FontWeights.regular,
        ),
      ],
    );
  }
}

class SummaryTab extends StatelessWidget {
  const SummaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AppText(
          text: 'Date',
          fontSize: AppDimensions.FONT_SIZE_14.sp,
          fontWeight: FontWeights.regular,
        ),
        AppText(
          text: 'Description',
          fontSize: AppDimensions.FONT_SIZE_14.sp,
          fontWeight: FontWeights.regular,
        ),
        AppText(
          text: 'Points',
          fontSize: AppDimensions.FONT_SIZE_14.sp,
          fontWeight: FontWeights.regular,
        ),
      ],
    );
  }
}