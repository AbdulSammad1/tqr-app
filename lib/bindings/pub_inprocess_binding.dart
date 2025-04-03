
import 'package:get/get.dart';

import '../publicity/conrtroller/pub_inprocess_controller.dart';

class PubInProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PubInProcessController>(
      () => PubInProcessController(),
    );
  }
}