import 'package:emmcare/model/client_goal_strategy_model.dart';
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
    await Future.delayed(Duration(microseconds: 0));
    // //
    // // Getting notification id from sharedpreference.
    // int? id;
    // final sharedpref = await SharedPreferences.getInstance();
    // id = sharedpref.getInt(UnReadNotificationViewState.KEYNOTIFICATIONID)!;
    // print(id);
    // // Getting notification id from sharedpreference.
    // //

    Map data = {
      "rating": star.toInt(),
    };
    try {
      dynamic response = await _apiServices.getPatchResponseWithAuthData(
          AppUrl.patchClientGoalStrategyUpdate(), data, token);
      return response = ClientGoalStrategyModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
