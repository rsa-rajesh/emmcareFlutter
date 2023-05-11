import 'package:emmcare/view_model/forgot_password_view_view_model.dart';
import 'package:flutter/material.dart';
import '../../res/colors.dart';
import '../../utils/utils.dart';
import 'otp_view.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  // Email Controllers
  var emailController = TextEditingController();
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
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: ExactAssetImage('assets/images/pwnbot.png'),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Please enter your registered email address to send one time password for verification.',
              style: TextStyle(
                  color: Color(0xFF59706F),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Enter email',
                    hintStyle: TextStyle(color: Color(0xFF979797)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1B383A)))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              color: AppColors.buttonColor,
              child: TextButton.icon(
                onPressed: () {
                  if (emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage("Please enter email", context);
                  } else {
                    Map data = {
                      "email": emailController.text.toString(),
                    };
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPView(),
                      ),
                    );
                    ForgotPasswordViewModel().forgotPasswordApi(data, context);
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                icon: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                label: Text(
                  "Send OTP",
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
