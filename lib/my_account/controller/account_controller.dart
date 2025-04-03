import 'dart:convert';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tqrfamily_bysaz_flutter/my_account/model/account_model.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../../distributor_login/controller/dsp_login_controller.dart';
import '../../main.dart';
import '../../repository/account_repo/account_repo.dart';
import '../../res/routes/route_name.dart';
import '../../services/app_urls.dart';
import '../../utils/constants.dart';



class AccountController extends GetxController {
  final AccountRepo accountRepo = AccountRepo();
  var dspLoginController = Get.put(DspLoginController());
  List<dynamic> myAccountResponse = [];
  var accountModel = <AccountModel>[].obs;
  var name = ''.obs;
  var category = ''.obs;
  var area = ''.obs;
  var city = ''.obs;
  var region = ''.obs;
  var parentCustomer = ''.obs;
  var versionId = '0.0'.obs;
  var isLogOut = false.obs;
  PackageInfo? packageInfo;

  Future<void> getUserDetails() async {
    var data = {
      "SPNAME": "CRMMAP_WalletSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
      "ReportQueryValue":["0","4","${box.read('userNumber')}"],
    };
    accountRepo.accountDetailApi(data).then((value) {
      myAccountResponse = jsonDecode(value);
      accountModel.value =
          myAccountResponse.map((e) => AccountModel.fromJson(e)).toList();
      name.value = '${accountModel.first.customerName}';
      category.value = '${accountModel.first.customerCategory}';
      area.value = '${accountModel.first.area}';
      city.value = '${accountModel.first.city}';
      region.value = '${accountModel.first.region}';
      parentCustomer.value = '${accountModel.first.parentCustomer}';
    //  debugPrint('response $value');
    }).onError((error, stackTrace) {
      Utils.toastMessage('Something went wrong');
       //debugPrint('>>>>>>getting user $error <<<<<');
     //  debugPrint("error $stackTrace");
    });
  }



  void logOutMethod() {
    if(box.read('dspRlogin')==true){
     box.write('dspRlogin',false);
    box.write('isDistributorLogin', true);
    Get.offAllNamed(RouteName.bottomNavScreen,);
    } else if(box.read('adminLogin')==true){
      box.write('dspRlogin',dspLoginController.dspRLogin = false);
      //logger.i('2');
      box.remove('dspRlogin',);
      box.remove('adminLogin',);
      box.remove('dotBtn',);
      box.remove('isDistributorLogin',);
      box.remove('userNumber');
      box.remove('walletPoints');
      box.remove('loginUser');
      box.remove('adminNum');

      Future.delayed(const Duration(seconds: 1), () {
        // Get.back;
        isLogOut.value = false;
        Utils.appSnackBar(
          title: 'Success',
          subtitle: 'Logout Successfully',
          bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
        );
        Get.offAllNamed(
          RouteName.loginScreen,
        );
      });
     // Get.offAllNamed(RouteName.bottomNavScreen,);
    }
    else{
      isLogOut.value = true;
      box.remove('userNumber');
      box.remove('walletPoints');
      box.remove('loginUser');
      box.remove('isDistributorLogin');
      box.remove('isDLogin');
      Future.delayed(const Duration(seconds: 1), () {
        // Get.back;
        isLogOut.value = false;
        Utils.appSnackBar(
          title: 'Success',
          subtitle: 'Logout Successfully',
          bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
        );
        Get.offAllNamed(
          RouteName.loginScreen,
        );
      });
    }

  }

  Future<void> getId() async {
    packageInfo = await PackageInfo.fromPlatform();
    versionId.value = packageInfo?.version ?? '';
  }

   Future<void> logoutCall() async {
    final url = Uri.parse(AppUrls().ACCOUNT_DATA_URL);
    final headers = {'Content-Type': 'application/json'};

  
    final body = jsonEncode({
      "SPNAME": "CRMMAP_MasterSP",
      "ReportQueryParameters":["@nType", "@nsType","@ContactNo"],
      "ReportQueryValue":["0","8", '${box.read('userNumber')}']
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('api called');
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<dynamic>> changePassword(String phoneNo, String oldPassword, String newPassword) async {
    final url = Uri.parse(AppUrls().ACCOUNT_DATA_URL);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "SPNAME": "CRMMAP_MasterSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo1","@OldPwd","@nPwd"],
      "ReportQueryValue": ["0", "7", phoneNo, oldPassword, newPassword]
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void onClose() {
    accountModel.clear();
    myAccountResponse.clear();
    super.onClose();
  }


  

 

 
}
