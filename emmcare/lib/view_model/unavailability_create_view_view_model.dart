import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/unavailability_repository.dart';
import '../utils/utils.dart';

class UnavailabilityViewViewModel with ChangeNotifier {
  final _myRepo = UnavailabilityRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> unavailabilityCreate(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.unavailabilityCreate(data).then((value) {
      setLoading(false);
      // Utils.toastMessage("Unavailability Created!");
      Utils.flushBarErrorMessage('Unavailability Created!', context);
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
