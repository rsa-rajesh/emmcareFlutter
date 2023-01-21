import 'package:emmcare/model/user_model.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/view_model/user_view_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      print(value.token.toString());
      if (value.token.toString() == "null" || value.token.toString() == "") {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    }).onError(
      (error, stackTrace) {
        if (kDebugMode) {
          print(
            error.toString(),
          );
        }
      },
    );
  }
}
