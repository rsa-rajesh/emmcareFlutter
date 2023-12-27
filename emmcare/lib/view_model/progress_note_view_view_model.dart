import 'package:emmcare/repository/progress_note_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';
import '../widgets/home_widgets/progress_view/progress_view.dart';

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
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Progress note Created!"),
                icon: Icon(
                  Icons.done,
                  size: 45,
                ),
                iconColor: Colors.green[400],
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop(); // dismiss dialog
                    },
                  ),
                ],
              ));

      Future.delayed(
          Duration(milliseconds: 1), () => ProgressViewState().refresh);
      // Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Navigator.pop(context);

      Utils.toastMessage(error.toString());
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
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Progress note Created!"),
                icon: Icon(
                  Icons.done,
                  size: 45,
                ),
                iconColor: Colors.green[400],
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop(); // dismiss dialog
                    },
                  ),
                ],
              ));
      // Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Navigator.pop(context);

      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
