import 'package:tqrfamily_bysaz_flutter/services/app_urls.dart';
import 'package:tqrfamily_bysaz_flutter/services/network/network_api_services.dart';

class PubNewRequestRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> pNewRequestApi(var data)async{
    dynamic response = _apiService.post(AppUrls().P_NEWREQ_URL, data);
    return response;
  }
  Future<dynamic> pNewRequestDropDownApi(var data)async{
    dynamic response = _apiService.post(AppUrls().P_NEWREQDROPD_URL, data);
    return response;
  }
  Future<dynamic> pNewRequestValidationApi(var data)async{
    dynamic response = _apiService.post(AppUrls().P_NEWREQ_VALID_URL, data);
    return response;
  }
}