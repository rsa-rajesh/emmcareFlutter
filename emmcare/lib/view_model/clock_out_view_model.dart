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

  Future<void> clockOut(BuildContext context) async {
    setLoading(true);
    _myRepo.clockOut().then((value) {
      setLoading(false);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Shift clocked out successfully."),
                icon: Icon(
                  Icons.done,
                  size: 45,
                ),
                iconColor: Colors.green[400],
              ));
      Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Future.delayed(Duration.zero, () => showAlert(context, error.toString()));
      Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(error.toString());
      }
    });
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
            ));
  }

  String splitError(String errorString) {
    String unSplittedString = errorString;
    //split string
    var splitteString = unSplittedString.split("='");
    return finalSplittedString(splitteString[1]);
  }

  String finalSplittedString(String finalSplitedString) {
    var _finalSplitedString = finalSplitedString.split("',");
    return _finalSplitedString[0];
  }
}
