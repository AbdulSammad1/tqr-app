import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';

import '../../phone/model/sms_api_model.dart';
import '../../repository/otp_repo/otp_repo.dart';
import '../../utils/utils.dart';

class OtpController extends GetxController {
  var otpTextField;
  var isValidate = false.obs;
  var resendToken = ''.obs;
  final userNumber = ''.obs;
  var verificationId;
  var loginTrue = false;
  var isResend = false.obs;
  Random random =  Random();
  var otpNum = 4465;
  var args = Get.arguments;
  List<dynamic> resendResponse = [];
  final OtpRepository otpRepository = OtpRepository();

  void generate4RandomNum() {
    otpNum = random.nextInt(9999);
    if (otpNum < 1000) {
      otpNum = otpNum + 1000;
      resendToken.value = '$otpNum';
    }else{
      resendToken.value = '$otpNum';
    }
  }

  void resendOtpMethod()async{
    isResend.value = true;
    generate4RandomNum();
    var data = {
      "SPNAME": "CRMMAP_MasterSP",
      "ReportQueryParameters":["@nType","@nsType","@ContactNo","@OtpCode"],
      "ReportQueryValue":["0","3","${args[1]}","$otpNum"]
    };

    Future.delayed(const Duration(milliseconds: 800),(){
      otpRepository.sendPhoneNumApi(data).then((value)async{
        resendResponse = jsonDecode(value);
        SmsApiModel smsApiModel = SmsApiModel(
          sMSApi: resendResponse[0]['SMSApi'],
        );
        Future.delayed(const Duration(seconds: 1), () {
          otpRepository.otpRequestApi(smsApiModel.sMSApi).then((value)async {
            isResend.value = false;
            Utils.toastMessage('resend successfully');

          }).onError((error, stackTrace) {
            Utils.appSnackBar(subtitle: 'Something went wrong');
          });
        });

      }).onError((error, stackTrace) {
        Utils.appSnackBar(subtitle: 'Error while sending OTP');
      });
    });
  }


  @override
  void onInit() {
    resendToken.value  = '${args[0]}';
    userNumber.value  = '${args[1]}';
    super.onInit();
  }

  @override
  void onClose() {
    otpNum = 0;
    otpTextField = null;
    resendToken.value = '';
    super.onClose();
  }
}
