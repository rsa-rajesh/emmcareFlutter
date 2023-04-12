import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/feedback_repository.dart';
import '../utils/utils.dart';

class FeedbackViewModel with ChangeNotifier {
  final _myRepo = FeedbackRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> feedback(
      BuildContext context, _attachment, _category, _msg) async {
    setLoading(true);
    _myRepo.feedback(_attachment, _category, _msg).then((value) {
      setLoading(false);
      // Utils.toastMessage("Progress note Created!");
      Utils.flushBarErrorMessage('Feedback added successfully.', context);
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
