
import 'package:get/get.dart';

import '../phone/controller/phone_controller.dart';

class PhoneBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneController>(() => PhoneController());
  }
}