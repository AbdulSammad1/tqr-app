
import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class SchemeHistoryRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> schemeHistoryApi(var data)async{
    dynamic response = _apiService.post(AppUrls().SCHEME_HOSTIRY_URL, data);
    return response;
  }
}