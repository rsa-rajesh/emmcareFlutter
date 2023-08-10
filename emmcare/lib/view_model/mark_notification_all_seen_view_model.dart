import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/mark_notification_all_seen_repository.dart';

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
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("All notifications marked as seen!"),
                icon: Icon(
                  Icons.done,
                  size: 45,
                ),
                iconColor: Colors.green[400],
              ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
        
      });
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
