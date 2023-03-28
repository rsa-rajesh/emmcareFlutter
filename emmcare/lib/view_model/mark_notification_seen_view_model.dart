import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/mark_notification_seen_repository.dart';
import '../utils/utils.dart';

class MarkNotificationSeenViewModel with ChangeNotifier {
  final _myRepo = MarkNotificationSeenRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> markSeen(BuildContext context) async {
    setLoading(true);

    _myRepo.markSeen().then((value) {
      setLoading(false);
      Utils.toastMessage("Notification marked as seen!");
      // Utils.flushBarErrorMessage('Notification marked as seen!', context);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
