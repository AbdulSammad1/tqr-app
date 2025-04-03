import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../login/controller/login_controller.dart';
import '../../main.dart';
import '../../repository/buy_scheme_repo/buy_scheme_repo.dart';
import '../../services/app_urls.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../model/buy_scheme_model.dart';

class SchemeController extends GetxController {
  Dio dio = Dio();

  dynamic value = 0.obs;
  var response;
  var SCHEME_URL = '${AppUrls.BASEURL}/getdata';
  var QTY_VALIDATION_URL = '${AppUrls.BASEURL}/getdata';
  var schemeModelList = <BuySchemeModel>[].obs;

  TextEditingController controller = TextEditingController();
  List<dynamic> schemeList = [];
  List<dynamic> maxQtyList = [];

  var memberName = ''.obs;
  final buySchemeRepo = BuySchemeRepo();

  var maxQtyAllowed = ''.obs;
  RxString? selectedValue = ''.obs;
  var loginController = Get.find<LoginController>();
  final autoFcs = false.obs;
  var focusNode = FocusNode();
   RxBool isSubmit = true.obs;

   Future<bool> refreshSchemeData() async {
    schemeModelList.clear();
    return await buySchemeMethodBool();
   }

  void addMethod() {
    if (controller.text != '') {
      controller.text = '${int.parse(controller.text) + 1}';
      update();
    } else {
      controller.text = '1';
      update();
    }
  }

  void minusMethod() {
    if (controller.text == '') {
      controller.text = '0';

      update();
    } else if (int.parse(controller.text) > 0) {
      controller.text = '${int.parse(controller.text) - 1}';
      update();
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> buySchemeMethod() async {
    if (await checkInternetConnection()) {
      Map data = {
        "SPNAME": "CRMMAP_SchemeSignSP",
        "ReportQueryParameters": ["@nType", "@nsType", "@AllowedTo", "@ContactNo"],
        "ReportQueryValue": [
          "0",
          "1",
          box.read('isDLogin') == true ? "Distributor" : "Retailer", "${box.read('userNumber')}"
        ]
      };

      try {
        // Make the API call
        final value = await buySchemeRepo.buySchemeApi(data);

        // Process the response
        Get.back();
        schemeList = jsonDecode(value);
        schemeModelList
            .addAll(schemeList.map((e) => BuySchemeModel.fromJson(e)).toList());
        memberName.value = schemeModelList[0].schemeName ?? '';
        update();
      } on DioError catch (error) {
        // Handle DioError based on the error type
        Get.back();
        if (error.response != null) {
          // The request was made and the server responded with an error status code
          final statusCode = error.response!.statusCode;
          final errorMessage = error.response!.data.toString();
          showDialogBox('Error', 'Status Code: $statusCode\nError Message: $errorMessage');
        } else {
          // Something else went wrong
          isSubmit.value = false;
          showDialogBox('Error', 'Scheme filhal dastyab nahi hai');
        }
      } catch (error, stackTrace) {
        // Get.back();
        isSubmit.value = false;
        showDialogBox('Error', 'Scheme filhal dastyab nahi hai');
      }
    } else {
      // No internet connection
       Get.back();
       isSubmit.value = false;
      showDialogBox('No Internet', 'Check your Internet Connection');
    }
  }

  Future<bool> buySchemeMethodBool() async {
  bool isSuccess = false; // Initialize with a default value

  if (await checkInternetConnection()) {
    Map data = {
      "SPNAME": "CRMMAP_SchemeSignSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@AllowedTo", "@ContactNo"],
      "ReportQueryValue": [
        "0",
        "1",
        box.read('isDLogin') == true ? "Distributor" : "Retailer",
        "${box.read('userNumber')}"
      ]
    };

    try {
      // Make the API call
      final value = await buySchemeRepo.buySchemeApi(data);
      print('Scheme response: $value');
      // Process the response
      Get.back();
      schemeList = jsonDecode(value);
      schemeModelList
          .addAll(schemeList.map((e) => BuySchemeModel.fromJson(e)).toList());
      memberName.value = schemeModelList[0].schemeName ?? '';
      update();

      isSuccess = true; // API call was successful
    } on DioError catch (error) {
      // Handle DioError based on the error type
      Get.back();
      if (error.response != null) {
        // The request was made and the server responded with an error status code
        final statusCode = error.response!.statusCode;
        final errorMessage = error.response!.data.toString();
        showDialogBox('Error', 'Status Code: $statusCode\nError Message: $errorMessage');
      } else {
        // Something else went wrong
        showDialogBox('Error', 'Scheme filhal dastyab nahi hai');
      }
    } catch (error, stackTrace) {
      Get.back();
      showDialogBox('Error', 'Scheme filhal dastyab nahi hai');
    }
  } else {
    // No internet connection
    Get.back();
    showDialogBox('No Internet', 'Check your Internet Connection');
  }

  return isSuccess;
}


  Future<void> qtyValidation(var schemeName, var quantityTxt) async {
    var data = {
      "SPNAME": "CRMMAP_SchemeSignSP",
      "ReportQueryParameters": [
        "@nType",
        "@nsType",
        "@SchemeName",
        "@Quantity",
        "@ContactNo"
      ],
      "ReportQueryValue": [
        "0",
        "0",
        "$schemeName",
        "$quantityTxt",
        "${box.read('userNumber')}"
      ]
    };

    buySchemeRepo.quantityCheckApi(data).then((value) {
      Get.back();
      maxQtyList = jsonDecode('$value');
      maxQtyAllowed.value = '${maxQtyList[0]['Status']}';
      if (maxQtyAllowed.value == '0') {
        Utils.appSnackBar(
          subtitle: '${maxQtyList[0]['Message']}',
          title: 'Sorry',
        );
      } else if (maxQtyAllowed.value == '1') {
        Utils.appSnackBar(
          subtitle: '${maxQtyList[0]['Message']}',
          title: 'Success',
          bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
        );
        Navigator.pop(Get.context!);
        print('---> ${maxQtyList[0]['Message']}');
      } else {
        Utils.appSnackBar(
          subtitle: 'Something went wrong, Please try again',
          title: 'Error',
        );
      }
    }).onError((error, stackTrace) {
      debugPrint('-->exception: $error');
      showDialogBox('Error', 'Something Went Wrong');
    });
  }

  @override
  void onClose() {
    schemeModelList.clear();
    controller.clear();
    controller.dispose();
    loginController.selectedValue?.value = '';

    super.onClose();
  }
}

class PdfApi {
  static Future<File> loadFromNetwork(String url) async {
    final response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final bytes = response.data;
    Get.back();
    return _storeFile(url, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
