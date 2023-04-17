import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/enquiry_repository.dart';
import '../utils/utils.dart';

class EnquiryViewModel with ChangeNotifier {
  final _myRepo = EnquiryRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> enquiryWithImage(
      BuildContext context, _attachment, _category, _msg) async {
    setLoading(true);
    _myRepo.enquiryWithImage(_attachment, _category, _msg).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Enquiry added successfully.', context);
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

  Future<void> enquiryWithoutImage(
      BuildContext context, _category, _msg) async {
    setLoading(true);
    _myRepo.enquiryWithoutImage(_category, _msg).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Enquiry added successfully.', context);
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
