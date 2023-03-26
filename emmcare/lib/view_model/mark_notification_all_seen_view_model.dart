import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/mark_notification_all_seen_repository.dart';
import '../utils/utils.dart';

class MarkNotificationAllSeenViewModel with ChangeNotifier {
  final _myRepo = MarkNotificationAllSeenRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> markAllSeen(BuildContext context) async {
    setLoading(true);

    _myRepo.markAllSeen().then((value) {
      setLoading(false);
      // Utils.toastMessage("All notifications marked as seen!");
      Utils.flushBarErrorMessage('All notifications marked as seen!', context);
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
