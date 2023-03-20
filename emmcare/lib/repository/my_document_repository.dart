import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/model/my_document_model.dart';
import 'package:emmcare/res/app_url.dart';

import '../model/user_model.dart';
import '../view_model/user_view_view_model.dart';

class MyDocumentRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<MyDocumentModel> fetchMyDocumentList(int page_Num) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(seconds: 3));
    try {
      // dynamic response = await _apiServices.getGetResponseWithAuth(
      //     AppUrl.getPersonalDocuments(page_Num), token);
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getPersonalDocuments(page_Num), token);
      return response = MyDocumentModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
