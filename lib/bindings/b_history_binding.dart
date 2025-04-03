import 'package:get/get.dart';

import '../branding/controller/b_history_controller.dart';

class BHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => BHistoryController(),
    );
  }
}
