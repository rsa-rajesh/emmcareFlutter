import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';
import '../../view/login_view.dart';

class ConfirmPasswordView extends StatefulWidget {
  const ConfirmPasswordView({super.key});
  @override
  State<ConfirmPasswordView> createState() => _ConfirmPasswordViewState();
}

class _ConfirmPasswordViewState extends State<ConfirmPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.appBarColor),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              keyboardType: TextInputType.emailAddress,
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
              keyboardType: TextInputType.emailAddress,
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
            Container(
              width: double.infinity,
              color: AppColors.buttonColor,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );
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
