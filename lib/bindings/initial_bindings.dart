import 'package:get/get.dart';

import '../dashboard/controller/dashboard_controller.dart';
import '../my_account/controller/account_controller.dart';
import '../my_wallet/controller/wallet_controller.dart';
import '../network/controller/network_controller.dart';
import '../notification/controller/notification_controller.dart';
import '../poinrequest/controller/point_req_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<NetworkController>(() => NetworkController());
    Get.lazyPut<AccountController>(() => AccountController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<MyWalletController>(() => MyWalletController());
    Get.lazyPut<PointRequestController>(() => PointRequestController());
  }
}
