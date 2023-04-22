import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/clock_out_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class ClockOutRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<ClockOutModel> clockOut() async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    int? shiftId;

    final sharedpref = await SharedPreferences.getInstance();
    shiftId = sharedpref.getInt(HomeViewState.KEYSHIFTID)!;

    try {
      dynamic response = await _apiServices.getPutResponseWithAuth(
          AppUrl.putClockOut(shiftId), token);
      return response = ClockOutModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
