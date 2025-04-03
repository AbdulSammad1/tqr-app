

import 'package:get/get.dart';

import '../signedScheme/controller/signed_controller.dart';


class SignedSchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignedSchController());
  }
}