import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';

import '../model/client_profile_goal_model.dart';
import '../model/user_model.dart';
import '../view_model/user_view_view_model.dart';

class ClientProfileGoalRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ClientProfileGoalModel> fetchClientProfileGoalList() async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getClientProfileGoalList(), token);
      return response = ClientProfileGoalModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
