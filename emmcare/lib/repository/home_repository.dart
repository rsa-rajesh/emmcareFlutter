import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/model/client_model_v2.dart';
import 'package:emmcare/res/app_url.dart';

class HomeRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  // Future<ClientModel> fetchClientList() async {
  //   try {
  //     dynamic response =
  //         await _apiServices.getGetApiResponse(AppUrl.clientListEndPoint);
  //     return response = ClientModel.fromJson(response);
  //   } catch (e) {
  //     throw e;
  //   }
  // }
    Future<ClientModel> fetchClientList() async {
    try {
      dynamic response =
          await _apiServices.getGetClintsResponse(AppUrl.clientListEndPoint);
      return response = new ClientModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
