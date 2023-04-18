import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/clock_out_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view_model/user_view_view_model.dart';

class ClockOutRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<ClockOutModel> clockOut(String datetime) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    Map data = {
      "clock_out": datetime,
    };

    try {
      dynamic response = await _apiServices.getPutResponseWithAuthData(
          AppUrl.putClockOut(), data, token);
      return response = ClockOutModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
