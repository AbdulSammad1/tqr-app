

import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class NotificationRepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> notificationApi(var data)async{
    dynamic response = _apiService.post(AppUrls().NOTIFICATION_URL, data);
    return response;
  }
}