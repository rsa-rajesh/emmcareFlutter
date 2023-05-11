import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/mark_notification_seen_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view_model/user_view_view_model.dart';
import '../widgets/notification_widgets/unread_notification_view.dart';

class MarkNotificationSeenRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<MarkNotificationSeenModel> markSeen() async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    //
    // Getting notification id from sharedpreference.
    int? id;
    final sharedpref = await SharedPreferences.getInstance();
    id = sharedpref.getInt(UnReadNotificationViewState.KEYNOTIFICATIONID)!;
    print(id);
    // Getting notification id from sharedpreference.
    //

    Map data = {
      "id": id.toString(),
    };
    try {
      dynamic response = await _apiServices.getPostResponseWithAuthData(
          AppUrl.postMarkNotificationSeen(), jsonEncode(data), token);
      return response = MarkNotificationSeenModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
