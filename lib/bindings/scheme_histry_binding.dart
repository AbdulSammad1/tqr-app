
import 'package:get/get.dart';

import '../scheme/controller/scheme_histry_controller.dart';

class SchemeHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchemeHistoryController>(
      () => SchemeHistoryController(),
    );
  }
}