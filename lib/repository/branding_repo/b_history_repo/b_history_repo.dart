
import 'package:tqrfamily_bysaz_flutter/services/app_urls.dart';
import 'package:tqrfamily_bysaz_flutter/services/network/network_api_services.dart';

class BHistoryRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> bHistoryApi(var data)async{
    dynamic response = _apiService.post(AppUrls().B_HISTORY_URL, data);
    return response;
  }
}