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

  Future<void> subEvent(
      BuildContext context, _attachment, _category, _msg) async {
    setLoading(true);
    _myRepo.subEvent(_attachment, _category, _msg).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Sub event added successfully.', context);
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
