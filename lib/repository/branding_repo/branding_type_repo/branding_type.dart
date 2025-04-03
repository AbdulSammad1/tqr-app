

import '../../../services/app_urls.dart';
import '../../../services/network/network_api_services.dart';

class BrandingTypeRepo{
  final _apiService = NetworkApiServices();


  Future<dynamic> brandingTypeApi(var data)async{
    dynamic response = _apiService.post(AppUrls().BRANDING_TYPE_URL, data);
    return response;
  }
}