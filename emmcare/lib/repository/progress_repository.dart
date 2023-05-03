import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/progress_model.dart';
import '../model/user_model.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class ProgressRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ProgressModel> fetchProgressList(context) async {
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
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getProgressNoteList(obj_id), token);
      return response = ProgressModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
