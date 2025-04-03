import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class DspRetailerLoginRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> dspRetailerLoginApi(var data)async{
    dynamic response = _apiService.post(AppUrls().DSP_RETAILER_LOGIN_URL, data);
    return response;
  }

  Future<dynamic> dspRetailerOTPApi(var data)async{
    dynamic response = _apiService.post(AppUrls().DSP_RETAILER_OTP_URL, data);
    return response;
  }

  Future<dynamic> dspOTPUpdateApi(var data)async{
    dynamic response = _apiService.post(AppUrls().DSP_LOGIN_OTP_UPDATE_URL, data);
    return response;
  }
}