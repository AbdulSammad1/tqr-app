import 'package:get/get.dart';

import '../poinrequest/controller/point_req_controller.dart';

class PointReqBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<PointRequestController>(() => PointRequestController());
  }
}