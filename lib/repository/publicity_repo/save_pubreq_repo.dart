import 'package:tqrfamily_bysaz_flutter/services/app_urls.dart';
import 'package:tqrfamily_bysaz_flutter/services/network/network_api_services.dart';


class SavePubRequestRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> savePubRequestApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SAVE_PUBLICITY_URL, data);
    return response;
  }

}