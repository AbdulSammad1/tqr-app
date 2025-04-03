import '../../../services/app_urls.dart';
import '../../../services/network/network_api_services.dart';

class ImageNameRepo{
  final _apiService = NetworkApiServices();


  Future<dynamic> imageNameApi(var data)async{
    dynamic response = _apiService.post(AppUrls().IMAGE_NAME_URL, data);
    return response;
  }
}