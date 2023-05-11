import 'package:emmcare/data/response/api_response.dart';
import 'package:emmcare/model/read_notification_model.dart';
import 'package:flutter/cupertino.dart';
import '../repository/read_notification_repository.dart';

class ReadNotificationViewViewModel with ChangeNotifier {
  final _myRepo = ReadNotificationRepository();

  ApiResponse<ReadNotificationModel> readNotificationList =
      ApiResponse.loading();

  setReadNotificationList(ApiResponse<ReadNotificationModel> response) {
    readNotificationList = response;
    notifyListeners();
  }

  Future<void> fetchReadNotificationListApi(int page) async {
    setReadNotificationList(ApiResponse.loading());
    _myRepo.fetchReadNotificationList(page).then(
      (value) {
        setReadNotificationList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setReadNotificationList(ApiResponse.error(error.toString()));
      },
    );
  }
}
