
import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class PointsRepo{
  final _apiService = NetworkApiServices();

  Future<dynamic> pendingPointApi(var data)async{
    dynamic response = _apiService.post(AppUrls().POINT_PENDING_URL, data);
    return response;
  }

  Future<dynamic> pointHistoryApi(var data)async{
    dynamic response = _apiService.post(AppUrls().POINT_HISTORY_URL, data);
    return response;
  }
}