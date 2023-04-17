import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/injury_repository.dart';
import '../utils/utils.dart';

class InjuryViewModel with ChangeNotifier {
  final _myRepo = InjuryRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> injuryWithImage(
      BuildContext context, _attachment, _category, _msg) async {
    setLoading(true);
    _myRepo.injuryWithImage(_attachment, _category, _msg).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Injury added successfully.', context);
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

  Future<void> injuryWithoutImage(BuildContext context, _category, _msg) async {
    setLoading(true);
    _myRepo.injuryWithoutImage(_category, _msg).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Injury added successfully.', context);
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
