import 'package:tqrfamily_bysaz_flutter/services/network/network_api_services.dart';

import '../../services/app_urls.dart';

class PointRequestRepo {
  final _apiService = NetworkApiServices();


  Future<dynamic> pointRequestApi(var data)async{
    dynamic response = _apiService.post(AppUrls().POINT_HISTORY_URL, data);
    return response;
  }

}