import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class TransferPSmsRepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> transferPtSMSApi(var data)async{
    dynamic response = _apiService.post(AppUrls().TRANSFER_PT_SMS_URL, data);
    return response;
  }

}