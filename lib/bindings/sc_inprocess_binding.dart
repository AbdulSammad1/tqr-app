import 'package:get/get.dart';

import '../scheme/controller/sc_in_proceesscontroller.dart';

class ScInProcessBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ScInProcessController());
  }
}