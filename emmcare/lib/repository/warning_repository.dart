import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/user_model.dart';
import '../model/warning_model.dart';
import '../res/app_url.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class WarningRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<WarningModel> warningWithImage(_attachment, _category, _msg) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    //
    // Getting shift id from sharedpreference.
    int? obj_id;
    final sharedpref = await SharedPreferences.getInstance();
    obj_id = sharedpref.getInt(HomeViewState.KEYSHIFTID)!;
    print(obj_id);
    // Getting shift id from sharedpreference.
    //

    try {
      dynamic response =
          await _apiServices.getPostResponseWithAuthMultipartDataWithImage(
              AppUrl.postWarning(),
              _attachment,
              _category,
              _msg,
              obj_id,
              token);
      return response = WarningModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<WarningModel> warningWithoutImage(_category, _msg) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    //
    // Getting shift id from sharedpreference.
    int? obj_id;
    final sharedpref = await SharedPreferences.getInstance();
    obj_id = sharedpref.getInt(HomeViewState.KEYSHIFTID)!;
    print(obj_id);
    // Getting shift id from sharedpreference.
    //

    try {
      dynamic response =
          await _apiServices.getPostResponseWithAuthMultipartDataWithoutImage(
              AppUrl.postWarning(), _category, _msg, obj_id, token);
      return response = WarningModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
