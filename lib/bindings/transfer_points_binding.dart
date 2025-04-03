

import 'package:get/get.dart';

import '../transfer_points/controller/transfer_point_controller.dart';

class TransferPointsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferPointsController>(
      () => TransferPointsController(),
    );
  }
}