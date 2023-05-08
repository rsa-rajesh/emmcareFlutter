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
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Enquiry added successfully!"),
                icon: Icon(
                  Icons.done,
                  size: 45,
                ),
                iconColor: Colors.green[400],
              ));

      Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
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

  Future<void> enquiryWithoutImage(
      BuildContext context, _category, _msg) async {
    setLoading(true);
    _myRepo.enquiryWithoutImage(_category, _msg).then((value) {
      setLoading(false);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Enquiry added successfully!"),
                icon: Icon(
                  Icons.done,
                  size: 45,
                ),
                iconColor: Colors.green[400],
              ));

      Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
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
