
import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class OtpSuccessRepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> otpSuccessApi(var data)async{
    dynamic response = _apiService.post(AppUrls().PT_OTP_SUCCES_URL, data);
    return response;
  }

}