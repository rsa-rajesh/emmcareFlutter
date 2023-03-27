import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/tasks_model.dart';
import '../model/user_model.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class TasksRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<TasksModel> fetchTasksList() async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 1));

    //
    // Getting shift id from sharedpreference.
    int? shift;
    final sharedpref = await SharedPreferences.getInstance();
    shift = sharedpref.getInt(HomeViewState.KEYSHIFTID)!;
    print(shift);
    // Getting shift id from sharedpreference.
    //

    // int shift = 18;

    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getShiftTaskList(shift), token);
      return response = TasksModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
