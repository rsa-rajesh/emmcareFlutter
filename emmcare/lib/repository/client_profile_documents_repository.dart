import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/model/client_profile_documents_model.dart';
import 'package:emmcare/res/app_url.dart';

class ClientProfileDocumentsRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ClientProfileDocumentsModel> fetchClientProfileDocumentsList() async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse(AppUrl.clientProfileDocumentsListEndPoint);
      return response = ClientProfileDocumentsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
