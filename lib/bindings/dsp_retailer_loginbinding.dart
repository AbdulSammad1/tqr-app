import 'package:get/get.dart';

import '../dsp_retailer_login/controller/dsp_retailer_controller.dart';


class DspRetailerLoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DspRetailerLoginController>(() => DspRetailerLoginController());
  }

}