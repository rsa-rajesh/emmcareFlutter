import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view_model/services/notification_services.dart';
import 'package:emmcare/view_model/services/splash_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final Map arguments;
  const SplashView({super.key, required this.arguments});
  @override
  State<SplashView> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context, widget.arguments);
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBarColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/emmc_care_logo-white_bg.png",
              height: 80,
            ),
          ),
        ],
      ),
    );
  }
}
