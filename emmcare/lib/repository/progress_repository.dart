import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';
import 'package:flutter/material.dart';
import '../model/progress_model.dart';
import '../model/user_model.dart';
import '../view_model/user_view_view_model.dart';

class ProgressRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<ProgressModel> fetchProgressList(BuildContext context) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 1));
    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.progressEndPoint, token);
      return response = ProgressModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
