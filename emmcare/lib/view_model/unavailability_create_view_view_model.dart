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

  Future<void> unavailabilityCreate(dynamic datas, BuildContext context) async {
    setLoading(true);

    _myRepo.unavailabilityCreate(datas).then((value) {
      setLoading(false);
      Utils.toastMessage('Unavailability Created!');
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
