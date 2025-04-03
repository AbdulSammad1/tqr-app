import 'package:tqrfamily_bysaz_flutter/services/app_urls.dart';
import 'package:tqrfamily_bysaz_flutter/services/network/network_api_services.dart';

class PInProcessRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> pInProcessApi(var data)async{
    dynamic response = _apiService.post(AppUrls().P_INPROCESS_URL, data);
    return response;
  }

}