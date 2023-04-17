import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/warning_repository.dart';
import '../utils/utils.dart';

class WarningViewModel with ChangeNotifier {
  final _myRepo = WarningRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> warningWithImage(
      BuildContext context, _attachment, _category, _msg) async {
    setLoading(true);
    _myRepo.warningWithImage(_attachment, _category, _msg).then((value) {
      setLoading(false);
      // Utils.toastMessage("Warning Created!");
      Utils.flushBarErrorMessage('Warning created successfully.', context);
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

  Future<void> warningWithoutImage(
      BuildContext context, _category, _msg) async {
    setLoading(true);
    _myRepo.warningWithoutImage(_category, _msg).then((value) {
      setLoading(false);
      // Utils.toastMessage("Warning Created!");
      Utils.flushBarErrorMessage('Warning created successfully.', context);
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
