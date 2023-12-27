import 'package:emmcare/model/unavailable_list.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repository/unavailability_repository.dart';

class UnavailabilityViewViewModel with ChangeNotifier {
  final _myRepo = UnavailabilityRepository();

  bool _loading = false;

  bool get loading => _loading;

  List<UnavailableList> unavailabilityLists = [];

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> unavailabilityCreate(dynamic datas, BuildContext context) async {
    setLoading(true);

    _myRepo.unavailabilityCreate(datas).then((value) {
      setLoading(false);
      Navigator.pop(context);
      showAlert(context, "Unavailability saved successfully", "success");

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Navigator.pop(context);
      Future.delayed(
          Duration.zero, () => showAlert(context, error.toString(), "error"));
      // Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  showAlert(BuildContext context, String message, String status) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                  status == "error" ? splitError(message.toString()) : message),
              icon: Icon(
                Icons.error,
                size: 45,
              ),
              iconColor:
                  status == "error" ? Colors.red[400] : Colors.green[400],
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    if (status == "error") {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutesName.home, (r) => false);
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  String splitError(String errorString) {
    // String unSplittedString = errorString;
    //split string
    try {
      var splitteString = errorString.split('"');
      var a = splitteString[3];
      return a;
    } catch (e) {
      return errorString;
    }
  }

  Future<void> unavailabilityList() async {
    setLoading(true);

    _myRepo.unavailabilityList().then((value) {
      unavailabilityLists = List<UnavailableList>.from(
          value.map((x) => UnavailableList.fromJson(x)));
      if (kDebugMode) {
        print(value.toString());
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  isUnavailableDate(String date) {
    for (var a in unavailabilityLists) {
      if (a.unavailableDate.toString() == date.split(" ")[0]) {
        return true;
      }
    }
    return false;
  }

  getBlockoutDates() {
    List<DateTime> blockoutDates = [];
    for (var a in unavailabilityLists) {
      blockoutDates.add(DateTime.parse(a.unavailableDate.toString()));
    }
    return blockoutDates;
  }
}
