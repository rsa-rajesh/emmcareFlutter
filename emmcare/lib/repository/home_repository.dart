import 'dart:async';
import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/model/client_model.dart';
import 'package:emmcare/res/app_url.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../view_model/user_view_view_model.dart';

class HomeRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<ClientModel> fetchClientList(BuildContext context) async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getShiftList(), token);

      return response = ClientModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
