import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view_model/services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBarColor,
      body: Center(
        child: Text(
          "Emm Care",
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
