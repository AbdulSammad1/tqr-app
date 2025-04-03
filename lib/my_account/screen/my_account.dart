import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/my_account/screen/change_password_screen.dart';

import '../../dashboard/controller/dashboard_controller.dart';
import '../../main.dart';
import '../../utils/Fonts/AppDimensions.dart';
import '../../utils/Fonts/font_weights.dart';
import '../../utils/app_button.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../controller/account_controller.dart';
import '../widget/user_tile_widget.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var accountController = Get.find<AccountController>();
  var dashboardController = Get.find<DashboardController>();

  @override
  void initState() {
    accountController.getUserDetails();

    Future.wait([
      accountController.getUserDetails(),
      accountController.getId(),
      dashboardController.getUserName(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'Profile',
                        fontWeight: FontWeights.semiBold,
                        fontSize: AppDimensions.FONT_SIZE_18,
                        color: Constants.BLACK_COLOR,
                      ),
                      box.read('isDistributorLogin') == true
                          ? SizedBox(
                              height: 20.h,
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: SvgPicture.asset(
                            AppImages.USER_PROFILE_ICON,
                            height: 48.w,
                            width: 48.w,
                            color: Constants.PRIMARY_COLOR,
                          ),
                          title: AppText(
                            text: '${dashboardController.userName.value}',
                            color: Constants.PRIMARY_COLOR,
                            fontSize: AppDimensions.FONT_SIZE_16,
                            fontWeight: FontWeights.semiBold,
                          ),
                          horizontalTitleGap: 10,
                          subtitle: AppText(
                            text: '${box.read('userNumber')}',
                            color: Constants.PRIMARY_COLOR,
                            fontSize: AppDimensions.FONT_SIZE_18,
                            fontWeight: FontWeights.semiBold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                text: box.read('isDistributorLogin') == true
                                    ? 'Distributor Login'
                                    : 'Retailer Login',
                                color: Constants.BLACK_COLOR,
                                fontSize: AppDimensions.FONT_SIZE_16,
                                fontWeight: FontWeights.bold,
                              ),
                            ),

                            Obx(() {
                              return accountController.accountModel.isEmpty ==
                                      true
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Constants.PRIMARY_COLOR,
                                      ),
                                    )
                                  : Scrollbar(
                                      thumbVisibility: true,
                                      child: Container(
                                        height: 460.h,
                                        child: ListView.builder(
                                            itemCount: accountController
                                                .accountModel.length,
                                            shrinkWrap: true,
                                            itemBuilder: (_, int index) {
                                              return Column(
                                                children: [
                                                  Column(children: [
                                                    box.read('isDistributorLogin') ==
                                                            true
                                                        ? const SizedBox
                                                            .shrink()
                                                        : Container(
                                                            height: 66.h,
                                                            child: ListTile(
                                                              titleAlignment:
                                                                  ListTileTitleAlignment
                                                                      .top,
                                                              leading: Icon(
                                                                Icons
                                                                    .person_3_rounded,
                                                                size: 35.w,
                                                                color: Constants
                                                                    .PRIMARY_COLOR,
                                                              ),
                                                              title: AppText(
                                                                text:
                                                                    'Saz Distributor',
                                                                color: Constants
                                                                    .DARK_GREY_COLOR
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontSize:
                                                                    AppDimensions
                                                                        .FONT_SIZE_16,
                                                                fontWeight:
                                                                    FontWeights
                                                                        .bold,
                                                              ),
                                                              subtitle: AppText(
                                                                text:
                                                                    '${accountController.parentCustomer.value}',
                                                                color: Constants
                                                                    .BLACK_COLOR,
                                                                fontSize:
                                                                    AppDimensions
                                                                        .FONT_SIZE_14,
                                                                fontWeight:
                                                                    FontWeights
                                                                        .bold,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                            ),
                                                          ),
                                                  ]),
                                                  box.read('isDistributorLogin') ==
                                                          true
                                                      ? const SizedBox.shrink()
                                                      : SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 1.h,
                                                          child: Divider(
                                                            color: Constants
                                                                .DARK_GREY_COLOR,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                  UserTileWidget(
                                                    customerName:
                                                        accountController
                                                            .name.value,
                                                    customerCategory:
                                                        accountController
                                                            .category.value,
                                                    customerArea:
                                                        accountController
                                                            .area.value,
                                                    customerCity:
                                                        accountController
                                                            .city.value,
                                                    customerRegion:
                                                        accountController
                                                            .region.value,
                                                  ),
                                                  SizedBox(
                                                    height: 10.w,
                                                  ),


                                                  Obx(() {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        accountController
                                                                .isLogOut.isTrue
                                                            ? Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Constants
                                                                      .PRIMARY_COLOR,
                                                                ),
                                                              )
                                                            : box.read('dotBtn') ==
                                                                    false
                                                                ? const SizedBox
                                                                    .shrink()
                                                                : AppButton(
                                                                    width:
                                                                        110.w,
                                                                    height:
                                                                        40.h,
                                                                    btnText:
                                                                        'Logout',
                                                                    onPressed:
                                                                        () {
                                                                      print(
                                                                          '${box.read('userNumber')}');
                                                                      accountController
                                                                          .logoutCall();
                                                                      accountController
                                                                          .logOutMethod();
                                                                    },
                                                                  ),
                                                        SizedBox(
                                                          width: 10.h,
                                                        ),
                                                        box.read('isDistributorLogin') ==
                                                                true
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  Get.toNamed(
                                                                      ChangepasswordScreen
                                                                          .routeName);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: 40.h,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Constants
                                                                          .PRIMARY_COLOR),
                                                                  child: Text(
                                                                    'Change password',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17),
                                                                  ),
                                                                ),
                                                              )
                                                            : SizedBox(
                                                                height: 0,
                                                                width: 0,
                                                              ),
                                                      ],
                                                    );
                                                  }),
                                                   SizedBox(
                                                     height: 10.w,
                                                   ),
                                                   //app version
                                                   Obx(() {
                                                     return AppText(
                                                       text:
                                                           'Version: ${accountController.versionId.value}',
                                                       fontWeight:
                                                           FontWeights.bold,
                                                       fontSize: AppDimensions
                                                           .FONT_SIZE_12,
                                                     );
                                                   }),
                                                ],
                                              );
                                            }),
                                      ),
                                    );
                            }),
                            //logout btn
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.logout, color: Colors.white,), backgroundColor: Colors.red,),
    );
  }
}
