
import 'package:get/get.dart';

import '../publicity/conrtroller/p_history_controller.dart';

class PHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PHistoryController>(
      () => PHistoryController(),
    );
  }
}