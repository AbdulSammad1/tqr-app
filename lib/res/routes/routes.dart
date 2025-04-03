import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/bindings/initial_bindings.dart';
import 'package:tqrfamily_bysaz_flutter/bindings/notification_binding.dart';
import 'package:tqrfamily_bysaz_flutter/login/screen/login_screen.dart';
import 'package:tqrfamily_bysaz_flutter/publicity/screen/publicity_screen.dart';
import 'package:tqrfamily_bysaz_flutter/res/routes/route_name.dart';
import 'package:tqrfamily_bysaz_flutter/scheme/screen/sc_inprocess_screen.dart';
import 'package:tqrfamily_bysaz_flutter/signedScheme/screen/signed_card_screen.dart';
import 'package:tqrfamily_bysaz_flutter/splash/splash_screen.dart';

import '../../bindings/b_history_binding.dart';
import '../../bindings/branding_binding.dart';
import '../../bindings/dashboard_bindings.dart';
import '../../bindings/dsp_login_binding.dart';
import '../../bindings/dsp_retailer_loginbinding.dart';
import '../../bindings/edit_binding.dart';
import '../../bindings/in_progress_binding.dart';
import '../../bindings/item_list_binding.dart';
import '../../bindings/ledger_bindings.dart';
import '../../bindings/login_binding.dart';
import '../../bindings/new_req_binding.dart';
import '../../bindings/otp_binding.dart';
import '../../bindings/p_history_binding.dart';
import '../../bindings/phone_bindings.dart';
import '../../bindings/point_request_binding.dart';
import '../../bindings/points_card_binding.dart';
import '../../bindings/pub_inprocess_binding.dart';
import '../../bindings/publicity_binding.dart';
import '../../bindings/sc_inprocess_binding.dart';
import '../../bindings/scheme_binding.dart';
import '../../bindings/scheme_histry_binding.dart';
import '../../bindings/transfer_points_binding.dart';
import '../../bindings/type_binding.dart';
import '../../bindings/wallet_binding.dart';
import '../../bottom_nav/screen/bottom_nav_screen.dart';
import '../../branding/screen/b_history_screen.dart';
import '../../branding/screen/branding_screen.dart';
import '../../branding/screen/inprocess_screen.dart';
import '../../branding/screen/new_brand_req_screen.dart';
import '../../branding/screen/type_screen.dart';
import '../../dashboard/screen/dashboard_screen.dart';
import '../../distributor_login/screen/dsp_login_screen.dart';
import '../../dsp_retailer_login/screen/dsp_retailer_login.dart';
import '../../ledger/screen/ledger_screen.dart';
import '../../my_wallet/screen/wallet_screen.dart';
import '../../notification/screen/noification_screen.dart';
import '../../otp/screen/otp_screen.dart';
import '../../phone/screen/phone_screen.dart';
import '../../poinrequest/screen/point_request_screen.dart';
import '../../points/screen/points_card_screen.dart';
import '../../publicity/screen/item_list_screen.dart';
import '../../publicity/screen/p_history_screen.dart';
import '../../publicity/screen/pub_inprocess_screen.dart';
import '../../publicity/screen/pub_newreq_screen.dart';
import '../../scheme/screen/buy_scheme_screen.dart';
import '../../scheme/screen/scheme_history_screen.dart';
import '../../signedScheme/screen/signed_screen.dart';
import '../../transfer_points/screen/transfer_points_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: RouteName.loginScreen,
          page: () => const LoginScreen(),
          binding: LoginBinding(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.phoneScreen,
          page: () => const PhoneScreen(),
          binding: PhoneBindings(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.buySchemeScreen,
          page: () => const BuySchemeScreen(),
          binding: SchemeBinding(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.pointRequestScreen,
          page: () => const PointRequestScreen(),
          binding: PointReqBinding(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.otpScreen,
          page: () => const OtpScreen(),
          binding: OtpBinding(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.dashboardScreen,
          page: () => const DashboardScreen(),
          binding: DashBoardBinding(),
        ),
        GetPage(
          name: RouteName.bottomNavScreen,
          page: () => const BottomNavScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: RouteName.brandingScreen,
          page: () => const BrandingScreen(),
          binding: BrandingBinding(),
        ),
        GetPage(
          name: RouteName.publicityScreen,
          page: () => const PublicityScreen(),
          binding: PublicityBinding(),
        ),
        GetPage(
          name: RouteName.ledgerScreen,
          page: () => const LedgerScreen(),
          binding: LedgerBindings(),
        ),
        GetPage(
          name: RouteName.newBrandReqScreen,
          page: () => const NewBrandReqScreen(),
          binding: BrandingBinding(),
        ),
        GetPage(
          name: RouteName.dspLoginScreen,
          page: () => const DistributorLoginScreen(),
          binding: DistributorLoginBinding(),
        ),
        GetPage(
          name: RouteName.transferPointsScreen,
          page: () => const TransferPointsScreen(),
          binding: TransferPointsBinding(),
        ),
        GetPage(
          name: RouteName.scInProcessScreen,
          page: () => const ScInProcessScreen(),
          binding: ScInProcessBinding(),
        ),
        GetPage(
          name: RouteName.schemeHistoryScreen,
          page: () => const SchemeHistoryScreen(),
          binding: SchemeHistoryBinding(),
        ),
        GetPage(
          name: RouteName.notificationScreen,
          page: () => const NotificationScreen(),
          binding: NotificationBinding(),
        ),
        GetPage(
          name: RouteName.myWalletScreen,
          page: () => const WalletScreen(),
          binding: MyWalletBinding(),
        ),
        GetPage(
          name: RouteName.itemListScreen,
          page: () => const ItemListScreen(),
          binding: ItemListBinding(),
        ),
        GetPage(
          name: RouteName.typeScreen,
          page: () => const TypeScreen(),
          binding: TypeBinding(),
        ),
        GetPage(
          name: RouteName.pubNewRequestScreen,
          page: () => const PubNewReqScreen(),
          binding: NewRequestBinding(),
        ),
        GetPage(
          name: RouteName.inProcessScreen,
          page: () => const InProcessScreen(),
          binding: InProcessBinding(),
        ),
        GetPage(
          name: RouteName.pubInProcessScreen,
          page: () => const PubInProcessScreen(),
          binding: PubInProcessBinding(),
        ),
        GetPage(
          name: RouteName.bHistoryScreen,
          page: () => const BHistoryScreen(),
          binding: BHistoryBinding(),
        ),
        GetPage(
          name: RouteName.pHistoryScreen,
          page: () => const PHistoryScreen(),
          binding: PHistoryBinding(),
        ),
        GetPage(
          name: RouteName.dspRetailerLogin,
          page: () => const DspRetailerLogin(),
          binding: DspRetailerLoginBinding(),
        ),
        GetPage(
          name: RouteName.signedSchScreen,
          page: () => const SignedSchScreen(),
          binding: SignedSchBinding(),
        ),
        GetPage(
          name: RouteName.pointsCardScreen,
          page: () => const PointsCardScreen(),
          binding: PointsCardBinding(),
        ),
        
      ];
}
