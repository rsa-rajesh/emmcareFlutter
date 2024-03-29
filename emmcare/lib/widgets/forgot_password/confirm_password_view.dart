import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../view_model/confirm_password_view_view_model.dart';

class ConfirmPasswordView extends StatefulWidget {
  final String receivedEmail;
  final String receivedOtp;
  const ConfirmPasswordView(
      {super.key, required this.receivedEmail, required this.receivedOtp});
  @override
  State<ConfirmPasswordView> createState() => _ConfirmPasswordViewState();
}

class _ConfirmPasswordViewState extends State<ConfirmPasswordView> {
  // Password Controllers
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: newPasswordController,
              style: new TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black),
              autofocus: false,
              decoration: InputDecoration(
                hintText: "password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: confirmPasswordController,
              style: new TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black),
              autofocus: false,
              decoration: InputDecoration(
                hintText: "password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.buttonColor,
              ),
              child: TextButton(
                onPressed: () {
                  if (newPasswordController.text.isEmpty) {
                    Utils.flushBarErrorMessage("Enter new password.", context);
                  } else if (newPasswordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Enter confirm password", context);
                  } else {
                    if (newPasswordController.text.toString() !=
                        confirmPasswordController.text.toString()) {
                      Utils.flushBarErrorMessage(
                          "Password does not matches.", context);
                    } else {
                      Map data = {
                        "email": widget.receivedEmail,
                        "otp": widget.receivedOtp,
                        "password": newPasswordController.text.toString(),
                      };

                      ConfirmPasswordViewModel()
                          .confirmPasswordapi(data, context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  }
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
