import 'package:emmcare/repository/confirm_password_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

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
      Navigator.pop(context);
      Navigator.pushNamed(context, RoutesName.login);
      Utils.flushBarErrorMessage('Password changed successfully.', context);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  "Unable to change the password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                icon: Icon(
                  Icons.error,
                  size: 45,
                ),
                iconColor: Colors.red[400],
              ));
      Future.delayed(Duration(seconds: 1), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
