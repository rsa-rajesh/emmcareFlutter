import 'package:shared_preferences/shared_preferences.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/clock_in_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class ClockInRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<ClockInModel> clockIn() async {
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
          AppUrl.putClockIn(shiftId), token);
      return response = ClockInModel.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }
}
