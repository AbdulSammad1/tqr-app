
import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class SignedRepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> signedApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SIGNED_URL, data);
    return response;
  }

  Future<dynamic> signedhistoryApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SCHEME_HOSTORY_URL, data);
    return response;
  }

  Future<dynamic> signedEditApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SIGNED_EDIT_URL, data);
    return response;
  }

  Future<dynamic> signedStatusUpdateApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SIGNED_STATUS_UPDATE_URL, data);
    return response;
  }

  Future<dynamic> saveSignedDataApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SAVE_SIGNED_URL, data);
    return response;
  }

}