import 'package:shared_preferences/shared_preferences.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/progress_notes_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class ProgressNoteRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ProgressNotesModel> progressNoteWithImage(
      _attachment, _category, _msg) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    //
    // Getting notification id from sharedpreference.
    int? obj_id;
    final sharedpref = await SharedPreferences.getInstance();
    obj_id = sharedpref.getInt(HomeViewState.KEYSHIFTID)!;
    print(obj_id);
    // Getting notification id from sharedpreference.
    //

    try {
      dynamic response =
          await _apiServices.getPostResponseWithAuthMultipartDataWithImage(
              AppUrl.postProgressNotes(),
              _attachment,
              _category,
              _msg,
              obj_id,
              token);
      return response = ProgressNotesModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<ProgressNotesModel> progressNoteWithoutImage(_category, _msg) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    //
    // Getting notification id from sharedpreference.
    int? obj_id;
    final sharedpref = await SharedPreferences.getInstance();
    obj_id = sharedpref.getInt(HomeViewState.KEYSHIFTID)!;
    print(obj_id);
    // Getting notification id from sharedpreference.
    //

    try {
      dynamic response =
          await _apiServices.getPostResponseWithAuthMultipartDataWithoutImage(
              AppUrl.postProgressNotes(), _category, _msg, obj_id, token);
      return response = ProgressNotesModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
