import 'package:get/get.dart';

import '../scheme/controller/scheme_controller.dart';

class SchemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchemeController>(() => SchemeController());
  }
}