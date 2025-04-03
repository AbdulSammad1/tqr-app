import 'package:get/get.dart';

import '../ledger/controller/ledger_controller.dart';


class LedgerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LedgerController>(() => LedgerController());
  }
}