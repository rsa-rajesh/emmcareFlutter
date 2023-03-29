import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/unavailability_create_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view_model/user_view_view_model.dart';

class UnavailabilityRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<UnavailabilityCreateModel> unavailabilityCreate() async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    Map data = {
      "id": 0,
      "unavailable_date": "2023-03-31",
      "all_day": true,
      "start_time": "string",
      "end_time": "string",
      "unavailable_reason": "string",
      "added_by": "string",
      "staff": 0
    };
    try {
      dynamic response = await _apiServices.getPostResponseWithAuthData(
          AppUrl.postUnavailabilityCreate(), data, token);
      return response = UnavailabilityCreateModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
