
import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class OtpRepository {
  final _apiService = NetworkApiServices();
  Future<dynamic> otpRequestApi(var data)async{
    dynamic response = _apiService.get(data);
    return response;
  }
  Future<dynamic> sendPhoneNumApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SEND_PHONE_NUM_URL, data);
    return response;
  }
  Future<dynamic> otpValidationApi(var data)async{
    dynamic response = _apiService.post(AppUrls().OTP_VALIDATION_URL, data);
    return response;
  }

}