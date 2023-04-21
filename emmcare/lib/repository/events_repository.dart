import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:emmcare/res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import '../view/home_view.dart';
import '../view_model/user_view_view_model.dart';

class EventsRepository {
  late Response response;
  Dio dio = Dio();
  String token = "";

  fetchEventsList(int page) async {
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    int? obj_id;

    final sharedpref = await SharedPreferences.getInstance();
    obj_id = sharedpref.getInt(HomeViewState.KEYSHIFTID)!;

    response = await dio.get(AppUrl.getEventsList(page, obj_id),
        options: Options(headers: {
          'Accept': 'application/json',
          'Connection': 'keep-alive',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        }));

    return response.data;
  }
}
