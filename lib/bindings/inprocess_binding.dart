
import 'package:get/get.dart';

import '../branding/controller/inprocess_controller.dart';

class InProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InProcessController>(
      () => InProcessController(),
    );
  }
}