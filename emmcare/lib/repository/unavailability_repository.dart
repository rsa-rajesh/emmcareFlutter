import 'dart:convert';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view_model/user_view_view_model.dart';

class UnavailabilityRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future unavailabilityCreate() async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));

    List<dynamic> unavailable = [
      {
        "unavailable_date": "2023-04-01",
        "all_day": true,
        "start_time": "11:56:00",
        "end_time": "09:56:00",
        "unavailable_reason": "No",
        "added_by": "Emmc_AdminDR7X",
        "staff": 98
      }
    ];

    try {
      dynamic response = await _apiServices.getPostResponseWithAuthData(
          AppUrl.postUnavailabilityCreate(),
          json.encode(unavailable).toString(),
          token);
      // return response = UnavailabilityCreateModel.fromJson(response);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
