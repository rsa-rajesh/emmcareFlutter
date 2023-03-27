import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/mark_notification_all_seen_model.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';
import '../view_model/user_view_view_model.dart';

class MarkNotificationAllSeenRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();
  Future<MarkNotificationAllSeenModel> markAllSeen() async {
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 0));
    try {
      dynamic response = await _apiServices.getPostResponseWithAuth(
          AppUrl.markNotificationAllSeen(), token);
      return response = MarkNotificationAllSeenModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
