import 'package:emmcare/repository/progress_note_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class ProgressNoteViewModel with ChangeNotifier {
  final _myRepo = ProgressNoteRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> progressNoteWithImage(
    BuildContext context,
    _attachment,
    _category,
    _msg,
  ) async {
    setLoading(true);
    _myRepo.progressNoteWithImage(_attachment, _category, _msg).then((value) {
      setLoading(false);
      // Utils.toastMessage("Progress note Created!");
      Utils.flushBarErrorMessage('Progress note Created', context);
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

  Future<void> progressNoteWithoutImage(
    BuildContext context,
    _category,
    _msg,
  ) async {
    setLoading(true);
    _myRepo.progressNoteWithoutImage(_category, _msg).then((value) {
      setLoading(false);
      // Utils.toastMessage("Progress note Created!");
      Utils.flushBarErrorMessage('Progress note Created', context);
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