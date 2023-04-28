import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'confirm_password_view.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key});
  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter the OTP verification code.",
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
            SizedBox(
              height: 30.0,
            ),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              keyboardType: TextInputType.numberWithOptions(),
              onSubmit: (value) {
                print("OTP is => $value");
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              color: AppColors.buttonColor,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmPasswordView(),
                    ),
                  );
                },
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
