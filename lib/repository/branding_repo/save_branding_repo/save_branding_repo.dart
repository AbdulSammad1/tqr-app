import '../../../services/app_urls.dart';
import '../../../services/network/network_api_services.dart';

class SaveBrandingRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> saveBrandingApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SAVE_BRANDING_URL, data);
    return response;
  }
  Future<dynamic> scSaveValidationApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SCHEME_SAVE_VALIDATION_URL, data);
    return response;
  }
}