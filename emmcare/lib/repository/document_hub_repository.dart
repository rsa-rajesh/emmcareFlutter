import 'dart:async';
import 'package:emmcare/model/document_hub_model.dart';
import 'package:emmcare/res/app_url.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/user_model.dart';
import '../view_model/user_view_view_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DocumentHubRepository {
  String token = "";
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<DocumentHubModel> fetchMyDocumentList(int page) async {
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    var realtedUserType = decodedToken["role"];
    var realtedUserId = decodedToken["user_id"];
    // var realtedUserType = "";
    // var realtedUserId = "";
    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getDocumentHubList(page, realtedUserType, realtedUserId),
          token);
      return response = DocumentHubModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
