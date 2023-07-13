import 'package:emmcare/model/user_model.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:emmcare/view_model/user_view_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewViewModel().getUser();

  void checkAuthentication(BuildContext context, Map arguments) async {
    getUserData().then((value) async {
      print(value.access.toString());
      if (value.access.toString() == "null" || value.access.toString() == "") {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        await Future.delayed(Duration(seconds: 3));
        // Navigator.pushReplacementNamed(
        //   context,
        //   RoutesName.home,
        //   arguments: arguments,
        // );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeView(arguments: arguments)));
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
