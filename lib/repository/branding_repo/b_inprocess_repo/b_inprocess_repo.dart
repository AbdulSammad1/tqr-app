import 'package:tqrfamily_bysaz_flutter/services/app_urls.dart';
import 'package:tqrfamily_bysaz_flutter/services/network/network_api_services.dart';

class BInProcessRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> bInProcessApi(var data)async{
    dynamic response = _apiService.post(AppUrls().B_INPROCESS_URL, data);
    return response;
  }
}