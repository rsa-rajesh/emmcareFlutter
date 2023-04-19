import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:emmcare/res/app_url.dart';
import '../model/user_model.dart';
import '../view_model/user_view_view_model.dart';

class ClientProfileGoalRepository {
  late Response response;
  Dio dio = Dio();
  String token = "";

  fetchClientProfileGoalList(int page) async {
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));

    response = await dio.get(AppUrl.getClientProfileGoalList(page),
        options: Options(headers: {
          'Accept': 'application/json',
          'Connection': 'keep-alive',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        }));

    return response.data;
  }
}
