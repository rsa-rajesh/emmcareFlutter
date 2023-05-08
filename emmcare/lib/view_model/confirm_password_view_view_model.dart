import 'package:emmcare/repository/confirm_password_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/forgot_password/confirm_password_view.dart';

class ConfirmPasswordViewModel with ChangeNotifier {
  final _myRepo = ConfirmPasswordRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> confirmPasswordapi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.confirmPasswordapi(data).then((value) {
      setLoading(false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPasswordView(),
        ),
      );
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text('Password changed successfully'),
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
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(error.toString()),
                icon: Icon(
                  Icons.error,
                  size: 45,
                ),
                iconColor: Colors.red[400],
              ));
      Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
