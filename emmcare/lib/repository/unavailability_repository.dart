import 'dart:convert';

import 'package:emmcare/view/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view_model/user_view_view_model.dart';

class UnavailabilityRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future unavailabilityCreate(dynamic datas) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));

    try {
      dynamic response = await _apiServices.getPostResponseWithAuthData(
          AppUrl.postUnavailabilityCreate(),
          json.encode(datas).toString(),
          token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future unavailabilityList() async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    final sharedpref = await SharedPreferences.getInstance();
    var cltId = sharedpref.getInt(HomeViewState.KEYCLIENTID)!;
    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.unavailabilityList(cltId), token);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
