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
      Utils.flushBarErrorMessage('Event added successfully.', context);
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

  Future<void> subEventWithoutImage(
      BuildContext context, _category, _msg) async {
    setLoading(true);
    _myRepo.subEventWithoutImage(_category, _msg).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Event added successfully.', context);
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
