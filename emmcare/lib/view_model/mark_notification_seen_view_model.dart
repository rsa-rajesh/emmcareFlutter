import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/mark_notification_seen_repository.dart';
import '../utils/utils.dart';
import '../widgets/notification_widgets/unread_notification_view.dart';

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
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Notification marked as seen!"),
                icon: Icon(
                  Icons.done,
                  size: 45,
                ),
                iconColor: Colors.green[400],
              ));
      Future.delayed(Duration(seconds: 1), () {
        UnReadNotificationViewState().refresh();
      });
      Future.delayed(Duration(seconds: 2), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(error.toString()),
                icon: Icon(
                  Icons.error,
                  size: 45,
                ),
                iconColor: Colors.red[400],
              ));
      Future.delayed(Duration(seconds: 2), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
