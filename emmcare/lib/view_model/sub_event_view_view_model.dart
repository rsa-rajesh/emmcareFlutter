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
      Utils.toastMessage('Event added successfully.');
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

  Future<void> subEventWithoutImage(
      BuildContext context, _category, _msg) async {
    setLoading(true);
    _myRepo.subEventWithoutImage(_category, _msg).then((value) {
      setLoading(false);
      Utils.toastMessage('Event added successfully.');
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
