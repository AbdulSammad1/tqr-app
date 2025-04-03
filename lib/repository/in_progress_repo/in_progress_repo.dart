
import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class InProgressRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> inProgressApi(var data)async{
    dynamic response = _apiService.post(AppUrls().IN_PROGRESS_URL, data);
    return response;
  }
}