import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/incident_repository.dart';
import '../utils/utils.dart';

class IncidentViewModel with ChangeNotifier {
  final _myRepo = IncidentRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> incidentWithImage(
      BuildContext context, _attachment, _category, _msg) async {
    setLoading(true);
    _myRepo.incidentWithImage(_attachment, _category, _msg).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Incident added successfully.', context);
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

  Future<void> incidentWithoutImage(
      BuildContext context, _category, _msg) async {
    setLoading(true);
    _myRepo.incidentWithoutImage(_category, _msg).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Incident added successfully.', context);
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
