import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/view/about_screen.dart';
import 'package:emmcare/view/document_hub_screen.dart';
import 'package:emmcare/view/job_board_screen.dart';
import 'package:emmcare/view/login_screen.dart';
import 'package:emmcare/view/my_document_screen.dart';
import 'package:emmcare/view/my_schedule_screen.dart';
import 'package:emmcare/view/notification_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        );
      case RoutesName.my_schedule:
        return MaterialPageRoute(
          builder: (BuildContext context) => MyScheduleScreen(),
        );
      case RoutesName.my_document:
        return MaterialPageRoute(
          builder: (BuildContext context) => MyDocumentScreen(),
        );
      case RoutesName.about:
        return MaterialPageRoute(
          builder: (BuildContext context) => AboutScreen(),
        );
      case RoutesName.job_board:
        return MaterialPageRoute(
          builder: (BuildContext context) => JobBoardScreen(),
        );
      case RoutesName.document_hub:
        return MaterialPageRoute(
          builder: (BuildContext context) => DocumentHubScreen(),
        );
      case RoutesName.notification:
        return MaterialPageRoute(
          builder: (BuildContext context) => NotificationScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text("No route defined"),
              ),
            );
          },
        );
    }
  }
}
