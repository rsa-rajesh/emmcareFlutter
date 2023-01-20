import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/model/my_document_model.dart';
import 'package:emmcare/res/app_url.dart';

class MyDocumentRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<MyDocumentModel> fetchMyDocumentList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.myDocumentListEndPoint);
      return response = MyDocumentModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
