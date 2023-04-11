import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/progress_notes_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view_model/user_view_view_model.dart';

class ProgressNoteRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<ProgressNotesModel> progressNote(_attachment, _category, _msg) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    // //
    // // Getting notification id from sharedpreference.
    // int? id;
    // final sharedpref = await SharedPreferences.getInstance();
    // id = sharedpref.getInt(UnReadNotificationViewState.KEYNOTIFICATIONID)!;
    // print(id);
    // // Getting notification id from sharedpreference.
    // //

    try {
      dynamic response =
          await _apiServices.getPostResponseWithAuthMultipartData(
              AppUrl.postProgressNotes(), _attachment, _category, _msg, token);
      return response = ProgressNotesModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
