import 'package:get/get.dart';

import '../distributor_login/controller/dsp_login_controller.dart';


class DistributorLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DspLoginController>(
      () => DspLoginController(),
    );
  }
}