import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/sub_event_repository.dart';
import '../utils/utils.dart';

class SubEventViewModel with ChangeNotifier {
  final _myRepo = SubEventRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> subEventWithImage(
      BuildContext context, _attachment, _category, _msg) async {
    setLoading(true);
    _myRepo.subEventWithImage(_attachment, _category, _msg).then((value) {
      setLoading(false);
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Event added successfully!"),
                icon: Icon(
                  Icons.done,
                  size: 45,
                ),
                iconColor: Colors.green[400],
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop(); // dismiss dialog
                    },
                  ),
                ],
              ));

      Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Navigator.pop(context);

      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> subEventWithoutImage(
      BuildContext context, _category, _msg) async {
    setLoading(true);
    Navigator.pop(context);

    _myRepo.subEventWithoutImage(_category, _msg).then((value) {
      setLoading(false);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Event added successfully!"),
                icon: Icon(
                  Icons.done,
                  size: 45,
                ),
                iconColor: Colors.green[400],
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop(); // dismiss dialog
                    },
                  ),
                ],
              ));

      // Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Navigator.pop(context);

      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
