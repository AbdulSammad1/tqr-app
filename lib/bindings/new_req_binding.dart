
import 'package:get/get.dart';

import '../publicity/conrtroller/new_request_controller.dart';

class NewRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewRequestController>(() => NewRequestController());
  }
}