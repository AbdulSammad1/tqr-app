import 'package:get/get.dart';

class LoginController extends GetxController {
  var isEnabled = false.obs;
  RxBool isExpanded = false.obs;
  var selectOption = 'Select Option'.obs;
  var schemeList = ['Distributor', 'Retailer'].obs;
  var toggleValue = 0;
  var status = true.obs;
  RxString? selectedValue =''.obs;


  void toggleLanguage(var val){
    status.value = !status.value;
  }

  void toggleButton() {
    isEnabled.value = !isEnabled.value;
  }


@override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}