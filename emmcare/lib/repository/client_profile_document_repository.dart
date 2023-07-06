import 'dart:async';
import 'package:emmcare/res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/client_profile_documents_model.dart';
import '../model/user_model.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class ClientProfileDocumentsRepository {
  String token = "";

  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ClientProfileDocumentsModel> fetchClientProfileDocumentsList(
      int page) async {
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    //
    final sharedpref = await SharedPreferences.getInstance();
    var cltId = sharedpref.getInt(HomeViewState.KEYCLIENTID)!;
    //
    // var realtedUserType = "client";
    var realtedUserId = cltId;
    var realtedUserType = "";
    // var realtedUserId = "";
    print(cltId);

    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getClientDocuments(page, realtedUserType, realtedUserId),
          token);
      return response = ClientProfileDocumentsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
