import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/clock_in_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view_model/user_view_view_model.dart';

class ClockInRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<ClockInModel> clockIn(String datetime) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    Map data = {
      "clock_in": datetime,
    };
    
    try {
      dynamic response = await _apiServices.getPutResponseWithAuthData(
          AppUrl.putClockIn(), data, token);
      return response = ClockInModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
