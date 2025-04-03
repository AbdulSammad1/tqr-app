
import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class TransferPointsRepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> transferPointApi(var data)async{
    dynamic response = _apiService.post(AppUrls().TRANSFER_POINTS_URL, data);
    return response;
  }

  Future<dynamic> transferPtValidateApi(var data)async{
    dynamic response = _apiService.post(AppUrls().TRANSFER_PT_VALIDATE_URL, data);
    return response;
  }
}