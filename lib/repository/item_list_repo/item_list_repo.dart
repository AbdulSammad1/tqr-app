import '../../services/app_urls.dart';
import '../../services/network/network_api_services.dart';

class ItemListRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> itemListApi(var data)async{
    dynamic response = _apiService.post(AppUrls().ITEM_LIST_URL, data);
    return response;
  }
}