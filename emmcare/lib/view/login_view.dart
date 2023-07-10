import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/round_button.dart';
import 'package:emmcare/utils/utils.dart';
import 'package:emmcare/view_model/auth_view_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view_model/services/notification_services.dart';
import '../widgets/forgot_password/forgot_password_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  String _appVersion = "";
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  // Email and password Controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  NotificationServices notificationServices = NotificationServices();
  String? fcmToken;
  String? deviceType;
  @override
  void initState() {
    _getAppVersion();
    super.initState();
    notificationServices.getDeviceToken().then((value) {
      fcmToken = value;
    });
    checkDeviceType();
  }

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
      backgroundColor: AppColors.loginBodyBackgroudColor,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                    child: Image.asset(
                      "assets/images/emmc_care_logo-white_bg.png",
                      height: 180,
                      width: 250,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 19.0, horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 12, top: 16),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 12, bottom: 8, top: 10),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 12, left: 12),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: emailFocusNode,
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusedChange(
                                context, emailFocusNode, passwordFocusNode);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 12, bottom: 8, top: 10),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _obsecurePassword,
                        builder: (context, value, child) {
                          return Container(
                            margin: EdgeInsets.only(right: 12, left: 12),
                            child: TextFormField(
                              controller: passwordController,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              autofocus: false,
                              obscureText: _obsecurePassword.value,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                hintText: "Password",
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
                            ),
                          );
                        },
                      ),
                      SizedBox(height: height * .02),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordView()),
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(right: 12),
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * .10),

                      // RoundButton
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(bottom: 12.0, right: 12, left: 12),
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
                                "register_id": fcmToken.toString(),
                                "type": deviceType.toString(),
                              };

                              authViewModel.loginApi(data, context);
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Version\t" + _appVersion,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                    ),
                    VerticalDivider(
                      endIndent: 3,
                      indent: 1,
                      color: Colors.black,
                      thickness: 2,
                    ), //thickness of divier line
                    Text(
                      "Powered by @ pwnbot system.",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    setState(() {});
  }

  String? checkDeviceType() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      // Android specific code
      deviceType = "android";
      return deviceType;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      //iOS specific code
      deviceType = "ios";
      return deviceType;
    } else {
      //web or desktop specific code
      return null;
    }
  }
}
