import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/clock_out_repository.dart';
import '../utils/utils.dart';

class ClockOutViewModel with ChangeNotifier {
  final _myRepo = ClockOutRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> clockOut(BuildContext context, String datetime) async {
    setLoading(true);
    _myRepo.clockOut(datetime).then((value) {
      setLoading(false);
      Utils.toastMessage("Shift clocked out successfully.");
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
