import 'package:get/get.dart';

import '../branding/controller/branding_controller.dart';

class BrandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandingController>(
      () => BrandingController(),
    );
  }
}