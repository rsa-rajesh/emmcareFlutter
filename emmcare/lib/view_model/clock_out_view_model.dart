import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/clock_out_repository.dart';

class ClockOutViewModel with ChangeNotifier {
  final _myRepo = ClockOutRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> clockOut(BuildContext context) async {
    setLoading(true);
    bool a = await _myRepo.clockOut().then((value) {
      setLoading(false);
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(value.alertMsg.toString()),
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

      return true;
    }).onError((error, stackTrace) {
      setLoading(false);
      Navigator.pop(context);
      Future.delayed(Duration.zero, () => showAlert(context, error.toString()));
      // Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(error.toString());
      }
      return false;
    });

    return a;
  }

  showAlert(BuildContext context, String error) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(splitError(error.toString())),
              icon: Icon(
                Icons.error,
                size: 45,
              ),
              iconColor: Colors.red[400],
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop(); // dismiss dialog
                  },
                ),
              ],
            ));
  }

  String splitError(String errorString) {
    // String unSplittedString = errorString;
    // //split string
    // var splitteString = unSplittedString.split("='");
    // return finalSplittedString(splitteString[1]);

    String unSplittedString = errorString;
    if (errorString.contains("='")) {
      var splitteString = unSplittedString.split("='");
      return finalSplittedString(splitteString[1]);
    } else {
      return errorString;
    }
  }

  String finalSplittedString(String finalSplitedString) {
    var _finalSplitedString = finalSplitedString.split("',");
    return _finalSplitedString[0];
  }
}
