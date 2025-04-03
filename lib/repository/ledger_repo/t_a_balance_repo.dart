import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class TABalanceRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> allTimeRepo(var data)async{
    dynamic response = _apiService.post(AppUrls().ALL_TM_BALANCE_URL, data);
    return response;
  }
  Future<dynamic> thisMonthRepo(var data)async{
    dynamic response = _apiService.post(AppUrls().THIS_M_BALANCE_URL, data);
    return response;
  }
}