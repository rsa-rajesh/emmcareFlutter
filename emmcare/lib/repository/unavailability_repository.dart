import 'dart:convert';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view_model/user_view_view_model.dart';

class UnavailabilityRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future unavailabilityCreate(dynamic data) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));

    try {
      dynamic response = await _apiServices.getPostResponseWithAuthData(
          AppUrl.postUnavailabilityCreate(),
          json.encode(data).toString(),
          token);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
