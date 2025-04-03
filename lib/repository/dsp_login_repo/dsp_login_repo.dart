import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class DistributorLoginRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> dspLoginApi(var data)async{
    dynamic response = _apiService.post(AppUrls().DSP_LOGIN_URL, data);
    return response;
  }
}