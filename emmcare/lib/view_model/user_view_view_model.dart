import 'package:emmcare/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewViewModel with ChangeNotifier {
  // Saving User information.
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("access", user.access.toString());
    notifyListeners();
    return true;
  }

  // retreiving the saved user information.
  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? access = sp.getString("access");
    return UserModel(
      access: access.toString(),
    );
  }

  // Logging out the user.
  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("access");
    return true;
  }
}
