import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/clock_in_repository.dart';
import '../utils/utils.dart';

class ClockInViewModel with ChangeNotifier {
  final _myRepo = ClockInRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> clockIn(BuildContext context, String datetime) async {
    setLoading(true);
    _myRepo.clockIn(datetime).then((value) {
      setLoading(false);
      Utils.toastMessage("Shift clocked in successfully.");
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
