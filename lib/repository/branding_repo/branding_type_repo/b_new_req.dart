

import '../../../services/app_urls.dart';
import '../../../services/network/network_api_services.dart';

class BrandingNewRequest{
  final _apiService = NetworkApiServices();


  Future<dynamic> brandingTypeApi(var data)async{
    dynamic response = _apiService.post(AppUrls().B_NEW_REQUEST_URL, data);
    return response;
  }

  Future<dynamic> bNewRequestApi(var data)async{
    dynamic response = _apiService.post(AppUrls().B_NEW_REQUEST_URL, data);
    return response;
  }
}