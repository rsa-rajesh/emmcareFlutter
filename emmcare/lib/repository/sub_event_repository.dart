import 'package:shared_preferences/shared_preferences.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/sub_event_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class SubEventRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<SubEventModel> subEvent(_attachment, _category, _msg) async {
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
          await _apiServices.getPostResponseWithAuthMultipartData(
              AppUrl.postSubEvent(),
              _attachment,
              _category,
              _msg,
              obj_id,
              token);
      return response = SubEventModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
