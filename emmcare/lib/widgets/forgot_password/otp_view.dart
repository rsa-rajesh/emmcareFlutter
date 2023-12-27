import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/utils.dart';
import 'package:emmcare/view/login_view.dart';
import 'package:emmcare/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../view_model/Otp_view_view_model.dart';

class OTPView extends StatefulWidget {
  final String receivedEmail;
  const OTPView({super.key, required this.receivedEmail});
  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  String? finalOTP;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
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
            PinCodeTextField(
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.number,
              autoDismissKeyboard: true,
              autoUnfocus: true,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveColor: AppColors.buttonColor,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  selectedColor: Colors.greenAccent,
                  activeColor: Colors.blue),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.blue.shade50,
              enableActiveFill: true,
              controller: textEditingController,
              onCompleted: (v) {
                debugPrint("Completed");
                finalOTP = v;
              },
              onChanged: (value) {
                debugPrint(value);
                setState(() {
                  currentText = value;
                });
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: context,
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
                  dynamic otp = finalOTP;
                  widget.receivedEmail;
                  Map data = {
                    "email": widget.receivedEmail,
                    "otp": otp.toString()
                  };

                  if (finalOTP == null) {
                    Utils.flushBarErrorMessage("OTP not provided", context);
                  } else if (finalOTP!.length < 5) {
                    Utils.flushBarErrorMessage("OTP not provided", context);
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        context = context;
                        return const Loading(
                          'Verifying OTP',
                          false,
                        );
                      },
                    );

                    OtpViewModel()
                        .otpApi(data, otp, widget.receivedEmail, context);
                  }
                },
                child: Text(
                  "Verify OTP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "I remember my password",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return LoginView();
                      }), (r) {
                        return false;
                      });
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green[900]),
                    ),
                  )
                ])
          ],
        ),
      ),
    );
  }
}
