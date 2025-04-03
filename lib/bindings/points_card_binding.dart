
import 'package:get/get.dart';

import '../points/controller/points_card_controller.dart';

class PointsCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PointsCardController>(() => PointsCardController());
  }
}