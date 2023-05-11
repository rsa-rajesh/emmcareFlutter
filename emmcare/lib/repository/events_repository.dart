import 'dart:async';
import 'package:emmcare/model/events_model.dart';
import 'package:emmcare/res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/user_model.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class EventsRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  String token = "";
  Future<EventsModel> fetchEventsList(int page) async {
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    int? obj_id;
    final sharedpref = await SharedPreferences.getInstance();
    obj_id = sharedpref.getInt(HomeViewState.KEYSHIFTID)!;
    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getEventsList(page, obj_id), token);
      return response = EventsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
