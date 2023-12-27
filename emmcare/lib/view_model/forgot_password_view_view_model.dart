import 'package:emmcare/repository/forgot_Password_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/forgot_password/otp_view.dart';

class ForgotPasswordViewModel with ChangeNotifier {
  final _myRepo = ForgotPasswordRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> forgotPasswordApi(
      dynamic data, String email, BuildContext context) async {
    setLoading(true);

    _myRepo.forgotPasswordApi(data).then((value) {
      setLoading(false);
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OTPView(receivedEmail: email),
          ),
          (r) => false);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  'We have send you a mail with instructions about changing your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                icon: Icon(
                  Icons.done,
                  size: 45,
                ),
                iconColor: Colors.green[400],
              ));

      Future.delayed(Duration(seconds: 1), () => Navigator.of(context).pop());
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      Navigator.pop(context);

      setLoading(false);
      // showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //           content: Text(splitError(error.toString()) + "."),
      //           icon: Icon(
      //             Icons.error,
      //             size: 45,
      //           ),
      //           iconColor: Colors.red[400],
      //         ));
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  "The email you entered is not valid.",
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

  // String splitError(String errorString) {
  //   String unSplittedString = errorString;
  //   //split string
  //   var splitteString = unSplittedString.split('"');
  //   return splitteString[3];
  // }
}
