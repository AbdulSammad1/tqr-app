import 'package:tqrfamily_bysaz_flutter/services/network/network_api_services.dart';

import '../../services/app_urls.dart';


class AccountRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> accountDetailApi(var data)async{
    dynamic response = _apiService.post(AppUrls().ACCOUNT_DATA_URL, data);
    return response;
  }
}