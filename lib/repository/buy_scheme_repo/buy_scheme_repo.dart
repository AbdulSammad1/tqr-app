import 'package:tqrfamily_bysaz_flutter/services/network/network_api_services.dart';

import '../../services/app_urls.dart';

class BuySchemeRepo {
  final _apiService = NetworkApiServices();


  Future<dynamic> buySchemeApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SCHEME_URL, data);
    return response;
  }

  Future<dynamic> quantityCheckApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SCHEME_URL, data);
    return response;
  }

  Future<dynamic> saveSchemeApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SAVE_SCHEME_URL, data);
    return response;
  }

  Future<dynamic> getPdfUrl(var data)async{
    dynamic response = _apiService.get(data);
    return response;
  }


}