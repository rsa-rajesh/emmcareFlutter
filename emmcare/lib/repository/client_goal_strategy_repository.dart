import 'package:emmcare/model/client_goal_strategy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view_model/user_view_view_model.dart';

class ClientGoalStrategyRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<ClientGoalStrategyModel> clientGoalStrategy(double star) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int internalId = prefs.getInt('internalId')!;
    await Future.delayed(Duration(microseconds: 20));
    Map data = {
      "rating": star.toInt(),
    };
    try {
      dynamic response = await _apiServices.getPatchResponseWithAuthData(
          AppUrl.patchClientGoalStrategyUpdate(internalId), data, token);
      return response = ClientGoalStrategyModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
