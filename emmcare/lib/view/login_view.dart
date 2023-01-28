import 'package:emmcare/res/components/round_button.dart';
import 'package:emmcare/utils/utils.dart';
import 'package:emmcare/view_model/auth_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  // Email and password Controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  // Dispose
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  static String KEYEMAIL = "email";
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/app_logo_white.png",
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "EmmCare",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 19.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      style: new TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black),
                      autofocus: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        hintText: "Email",
                        labelText: "Email",
                        // prefix: Icon(Icons.email_rounded),
                        border: OutlineInputBorder(),
                      ),
                      onFieldSubmitted: (value) {
                        Utils.fieldFocusedChange(
                            context, emailFocusNode, passwordFocusNode);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _obsecurePassword,
                      builder: (context, value, child) {
                        return TextFormField(
                          controller: passwordController,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          autofocus: false,
                          obscureText: _obsecurePassword.value,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            hintText: "Password",
                            labelText: "Password",
                            prefix: Icon(Icons.lock_open_rounded),
                            suffixIcon: InkWell(
                              onTap: () {
                                _obsecurePassword.value =
                                    !_obsecurePassword.value;
                              },
                              child: Icon(
                                _obsecurePassword.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          focusNode: passwordFocusNode,
                        );
                      },
                    ),
                    SizedBox(height: height * .04),
                    InkWell(
                      onTap: () {
                        Dialog();
                      },
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: height * .17),

                    // RoundButton
                    Container(
                      width: double.infinity,
                      child: RoundButton(
                        title: "Login",
                        loading: authViewModel.loading,
                        onPress: () async {
                          if (emailController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                "Please enter email", context);
                          } else if (passwordController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                "Please enter password", context);
                          } else if (passwordController.text.length < 6) {
                            Utils.flushBarErrorMessage(
                                "Please Enter 6 digit password", context);
                          } else {
                            final sharedprefs =
                                await SharedPreferences.getInstance();

                            sharedprefs.setString(
                                KEYEMAIL, emailController.text.toString());
                            setState(() {
                              sharedprefs.getString(KEYEMAIL);
                            });
                            Map data = {
                              "email": emailController.text.toString(),
                              "password": passwordController.text.toString(),
                            };

                            // Map data = {
                            //   'email' : 'rostermanagement@emmc.com.au',
                            //   'password' : '132LangdonDrive',
                            // };

                            authViewModel.loginApi(data, context);
                            print("api hit");
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
