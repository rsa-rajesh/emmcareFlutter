import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/model/client_detail_model.dart';
import 'package:emmcare/res/app_url.dart';

class ClientDetailRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ClientDetailModel> fetchClientDetail() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.clientDetailEndPoint);
      return response = ClientDetailModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
