import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:emmcare/res/app_url.dart';
import '../model/user_model.dart';
import '../view_model/user_view_view_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class MyDocumentRepository {
  late Response response;
  Dio dio = Dio();
  String token = "";

  fetchDocumentList(int page) async {
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // var realtedUserType = decodedToken["role"];
    // var realtedUserId = decodedToken["user_id"];
    var realtedUserType = "";
    var realtedUserId = "";
    response = await dio.get(
        AppUrl.getPersonalDocuments(page, realtedUserType, realtedUserId),
        options: Options(headers: {
          'Accept': 'application/json',
          'Connection': 'keep-alive',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        }));

    return response.data;
  }
}
