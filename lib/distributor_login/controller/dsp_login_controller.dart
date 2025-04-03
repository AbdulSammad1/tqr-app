import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../main.dart';
import '../../repository/dsp_login_repo/dsp_login_repo.dart';
import '../../res/routes/route_name.dart';
import '../../services/app_urls.dart';
import '../../utils/constants.dart';
import '../model/dsp_login_model.dart';

class DspLoginController extends GetxController {
  var userIdController = TextEditingController();
  var passwordController = TextEditingController();
  var isDspTrue = false;
  final obSecureText = true.obs;
  List<dynamic> dspLoginList = [];
  var dspLoginModel = <DspLoginModel>[].obs;
  final DistributorLoginRepository _distributorLoginRepository =
      DistributorLoginRepository();
  var dspRLogin = false;
  var adminLogin = false;
  var showDotBtn = false;
  // Initial Selected Value
  String dropdownvalue = '';
  var verifyOtp = false.obs;
  var iDLogin = false;

  // List of items in our dropdown menu
  var items = [
    'Retailer',
    'Distributor',
  ];

  Future<void> saveDeviceId(String deviceId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('deviceId', deviceId);
    } catch (e) {
      print(e);
    }
  }

  void distributorLogin({var userId, var password}) async {
    if (await checkInternetConnection()) {
      var data = {
        "SPNAME": "CRMMAP_MasterSP",
        "ReportQueryParameters": [
          "@nType",
          "@nsType",
          "@nUserId",
          "@nPwd",
          "@StatusType"
        ],
        "ReportQueryValue": ["0", "1", "$userId", "$password", "MA-DS"]
      };

      print('hello dsp');
      _distributorLoginRepository.dspLoginApi(data).then((value) async {
        isDspTrue = true;
        dspLoginList = jsonDecode(value);
        print('hello $dspLoginList');
        for (var element in dspLoginList) {
          dspLoginModel.add(
            DspLoginModel.fromJson(element),
          );
        }

        int status = dspLoginList[0]['statusId'];

        String messageCaption = dspLoginList[0]['MessageCaption'];

        String deviceId = dspLoginList[0]['Deviceid'];

        print('status $status');
        var userNum = dspLoginModel[0].contactNo;

        await saveDeviceId(deviceId);

        if (status == 1) {
          box.write('userNumber', userNum);
          box.write('adminNum', userNum);
          box.write('distroPassword', password);
          box.write('distributorDevicekey', deviceId);
          Get.back();
          Future.delayed(const Duration(milliseconds: 800), () {
            box.write('loginUser', isDspTrue == true ? 1 : 0);
            box.write('isDistributorLogin', isDspTrue);
            Utils.appSnackBar(
                title: 'Success',
                subtitle: 'Login Successfully',
                bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8));
            debugPrint('---> user: ${dspLoginModel[0].contactNo}');
            box.write('dspRlogin', dspRLogin = false);
            box.write('adminLogin', adminLogin = true);
            box.write('dotBtn', showDotBtn = true);
            box.write('isDLogin', iDLogin = true);
            debugPrint('dspLogin ====> ${box.read('dspRlogin')}');
            Get.offAllNamed(
              RouteName.bottomNavScreen,
            );
          });
        } else {
          Get.back();
          Utils.appSnackBar(subtitle: messageCaption);
        }
      }).onError((error, stackTrace) {
        Get.back();
        if ('$error' == 'Invalid Request:  Bad Request') {
          // debugPrint('------------> error on login: $error');
          Utils.appSnackBar(
              subtitle: 'Please enter valid credentials', title: 'Error');
        } else {
          Utils.appSnackBar(subtitle: 'Something went wrong', title: 'Error');
        }
      });
    } else {
      showDialogBox('No Internet', 'Check your Internet Connection');
    }
  }

  Future<int> passwordCheck() async {
    final apiUrl = Uri.parse(AppUrls().NOTIFICATION_URL);
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'SPNAME': 'CRMMAP_WalletSP',
      'ReportQueryParameters': ['@nType', '@nsType', '@ContactNo', '@Password'],
      'ReportQueryValue': [
        "0",
        "39",
        "${box.read('userNumber')}",
        "${box.read('distroPassword')}"
      ]
    });

    final response = await http.post(apiUrl, headers: headers, body: body);

    print('response: $response');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final status = data[0]['StatusId'];
      print(status);

      return status;
    } else {
      throw Exception('Failed to connect to the API');
    }
  }

  void togglePassword() {
    obSecureText.value = !obSecureText.value;
  }

  @override
  void onClose() {
    userIdController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
