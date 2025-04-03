import '../../../services/app_urls.dart';
import '../../../services/network/network_api_services.dart';

class FTPRepo{
  final _apiService = NetworkApiServices();


  Future<dynamic> ftpApi(var data)async{
    dynamic response = _apiService.post(AppUrls().FTP_URL, data);
    return response;
  }
}