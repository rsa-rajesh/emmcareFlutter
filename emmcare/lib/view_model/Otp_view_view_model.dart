import 'package:emmcare/repository/otp_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/forgot_password/confirm_password_view.dart';

class OtpViewModel with ChangeNotifier {
  final _myRepo = OtpRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> otpApi(
      dynamic data, String otp, String email, BuildContext context) async {
    setLoading(true);

    _myRepo.otpApi(data).then((value) {
      setLoading(false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPasswordView(
            receivedEmail: email,
            receivedOtp: otp,
          ),
        ),
      );
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  'OTP Verified.',
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
      setLoading(false);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  "Invalid OTP.",
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
