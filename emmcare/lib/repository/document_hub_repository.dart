import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/model/document_hub_model.dart';
import 'package:emmcare/res/app_url.dart';

class DocumentHubRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<DocumentHubModel> fetchDocumentHubList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.documentHubListEndPoint);
      return response = DocumentHubModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
