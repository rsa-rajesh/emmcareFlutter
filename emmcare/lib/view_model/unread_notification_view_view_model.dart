import 'package:emmcare/data/response/api_response.dart';
import 'package:flutter/cupertino.dart';
import '../model/unread_notification_model.dart';
import '../repository/unread_notification_repository.dart';

class UnReadNotificationViewViewModel with ChangeNotifier {
  final _myRepo = UnReadNotificationRepository();

  ApiResponse<UnReadNotificationModel> unReadNotificationList =
      ApiResponse.loading();

  setUnReadNotificationList(ApiResponse<UnReadNotificationModel> response) {
    unReadNotificationList = response;
    notifyListeners();
  }

  Future<void> fetchUnReadNotificationListApi(int page) async {
    setUnReadNotificationList(ApiResponse.loading());
    _myRepo.fetchUnReadNotificationList(page).then(
      (value) {
        setUnReadNotificationList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setUnReadNotificationList(ApiResponse.error(error.toString()));
      },
    );
  }
}
