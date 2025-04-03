import 'package:get/get.dart';

import '../pdf_view/controller/pdf_view_controller.dart';

class PdfViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PdfViewController());
  }
}
