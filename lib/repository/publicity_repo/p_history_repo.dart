import 'package:tqrfamily_bysaz_flutter/services/app_urls.dart';
import 'package:tqrfamily_bysaz_flutter/services/network/network_api_services.dart';

class PHistoryRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> pHistoryApi(var data)async{
    dynamic response = _apiService.post(AppUrls().P_HISTORY_URL, data);
    return response;
  }

}