import 'dart:async';
import 'package:emmcare/res/app_url.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/client_profile_goal_model.dart';
import '../model/user_model.dart';
import '../view_model/user_view_view_model.dart';

class ClientProfileGoalRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  String token = "";

  Future<ClientProfileGoalModel> fetchClientProfileGoalList(int page) async {
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getClientProfileGoalList(page), token);
      return response = ClientProfileGoalModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
