import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/model/client_profile_detail_model.dart';
import 'package:emmcare/res/app_url.dart';

class ClientProfileDetailRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ClientProfileDetailModel> fetchClientProfileDetailList() async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse(AppUrl.clientProfileDetailEndPoint);
      return response = ClientProfileDetailModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
