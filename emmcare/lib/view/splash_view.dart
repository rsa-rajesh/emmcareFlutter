import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view_model/services/notification_services.dart';
import 'package:emmcare/view_model/services/splash_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);

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
      body: Center(
        child: Text(
          "Pwnbot",
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
