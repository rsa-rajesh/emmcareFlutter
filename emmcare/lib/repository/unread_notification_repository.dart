import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';
import '../model/unread_notification_model.dart';
import '../model/user_model.dart';
import '../view_model/user_view_view_model.dart';

class UnReadNotificationRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  String token = "";
  bool is_seen = false;
  Future<UnReadNotificationModel> fetchUnReadNotificationList(int page) async {
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    try {
      dynamic response = await _apiServices.getGetResponseWithAuth(
          AppUrl.getNotification(page, is_seen), token);
      return response = UnReadNotificationModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
