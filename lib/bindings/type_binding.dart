

import 'package:get/get.dart';

import '../branding/controller/type_controller.dart';

class TypeBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => TypeController());
  }
}