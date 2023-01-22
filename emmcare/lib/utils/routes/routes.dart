import 'package:emmcare/widgets/home_widgets/client_detail_view.dart';
import 'package:emmcare/widgets/my_document_widgets/my_document_viewer.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/view/about_view.dart';
import 'package:emmcare/view/document_hub_view.dart';
import 'package:emmcare/view/job_board_view.dart';
import 'package:emmcare/view/login_view.dart';
import 'package:emmcare/view/my_document_view.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:emmcare/view/notification_view.dart';
import 'package:emmcare/view/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashView(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginView(),
        );
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomeView(),
        );
      case RoutesName.my_document:
        return MaterialPageRoute(
          builder: (BuildContext context) => MyDocumentView(),
        );
      case RoutesName.about:
        return MaterialPageRoute(
          builder: (BuildContext context) => AboutView(),
        );
      case RoutesName.job_board:
        return MaterialPageRoute(
          builder: (BuildContext context) => JobBoardView(),
        );
      case RoutesName.document_hub:
        return MaterialPageRoute(
          builder: (BuildContext context) => DocumentHubView(),
        );
      case RoutesName.notification:
        return MaterialPageRoute(
          builder: (BuildContext context) => NotificationView(),
        );
      case RoutesName.document_open:
        return MaterialPageRoute(
          builder: (BuildContext context) => MyDocumentViewer(),
        );

      case RoutesName.client_detail:
        return MaterialPageRoute(
          builder: (BuildContext context) => ClientDetailView(),
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
