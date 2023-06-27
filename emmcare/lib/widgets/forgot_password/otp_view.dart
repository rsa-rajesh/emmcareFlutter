import 'package:emmcare/res/colors.dart';
import 'package:emmcare/widgets/forgot_password/confirm_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../view_model/Otp_view_view_model.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key});
  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  String? finalOTP;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Enter the OTP verification code.",
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
            SizedBox(
              height: 50.0,
            ),
            OtpTextField(
              numberOfFields: 6,
              showFieldAsBox: true,
              showCursor: true,
              autoFocus: false,
              borderColor: Colors.black,
              clearText: true,
              enabled: true,
              textStyle: TextField.materialMisspelledTextStyle,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              keyboardType: TextInputType.numberWithOptions(),
              onSubmit: (value) {
                finalOTP = value;
              },
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.buttonColor,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmPasswordView(),
                    ),
                  );
                  // dynamic data = finalOTP;
                  // print(data);
                  // OtpViewModel().otpApi(data, context);
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
