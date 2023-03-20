import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/model/client_profile_documents_model.dart';
import 'package:emmcare/res/app_url.dart';
import '../model/user_model.dart';
import '../view_model/user_view_view_model.dart';

class ClientProfileDocumentsRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ClientProfileDocumentsModel> fetchClientProfileDocumentsList(
      int page_Num) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(seconds: 3));
    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getPersonalDocuments(page_Num), token);
      print("Repository" + "$page_Num");
      return response = ClientProfileDocumentsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
