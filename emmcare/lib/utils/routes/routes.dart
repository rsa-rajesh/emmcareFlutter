import 'package:emmcare/widgets/home_widgets/client_detail_view.dart';
import 'package:emmcare/widgets/home_widgets/details_view/client_profile_view/client_profile_sub_views/client_profile_documents.dart';
import 'package:emmcare/widgets/home_widgets/details_view/client_profile_view/client_profile_sub_views/client_profile_goal.dart';
import 'package:emmcare/widgets/home_widgets/details_view/client_profile_view/client_profile_view.dart';
import 'package:emmcare/widgets/home_widgets/events_view/shift_report_view.dart';
import 'package:emmcare/widgets/home_widgets/progress_view/progress_sub_views/enquiry_view.dart';
import 'package:emmcare/widgets/home_widgets/progress_view/progress_sub_views/warning_view.dart';
import 'package:emmcare/widgets/home_widgets/progress_view/progress_sub_views/feedback_view.dart';
import 'package:emmcare/widgets/home_widgets/progress_view/progress_sub_views/injury_view.dart';
import 'package:emmcare/widgets/home_widgets/progress_view/progress_sub_views/incident_view.dart';
import 'package:emmcare/widgets/home_widgets/progress_view/progress_sub_views/sub_event_view.dart';
import 'package:emmcare/widgets/home_widgets/progress_view/progress_sub_views/progress_notes_view.dart';
import 'package:emmcare/widgets/file_viewer/my_document_viewer.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/view/about_view.dart';
import 'package:emmcare/view/login_view.dart';
import 'package:emmcare/view/my_document_view.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:emmcare/view/notification_view.dart';
import 'package:emmcare/view/splash_view.dart';
import 'package:emmcare/widgets/notification_widgets/read_notification_view.dart';
import 'package:emmcare/widgets/notification_widgets/unread_notification_view.dart';
import 'package:flutter/material.dart';

import '../../view/document_hub_view.dart';
import '../../widgets/home_widgets/progress_view/progress_view.dart';
import '../../widgets/home_widgets/unavailability_view/unavailability_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashView(
            arguments: {},
          ),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginView(),
        );
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomeView(
            arguments: {},
          ),
        );
      case RoutesName.my_document:
        return MaterialPageRoute(
          builder: (BuildContext context) => MyDocumentView(),
        );
      case RoutesName.document_hub:
        return MaterialPageRoute(
          builder: (BuildContext context) => DocumentHubView(),
        );
      case RoutesName.about:
        return MaterialPageRoute(
          builder: (BuildContext context) => AboutView(),
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

      case RoutesName.injury:
        return MaterialPageRoute(
          builder: (BuildContext context) => InjuryView(),
        );

      case RoutesName.warning:
        return MaterialPageRoute(
          builder: (BuildContext context) => WarningView(),
        );

      case RoutesName.event:
        return MaterialPageRoute(
          builder: (BuildContext context) => EventView(),
        );

      case RoutesName.enquiry:
        return MaterialPageRoute(
          builder: (BuildContext context) => EnquiryView(),
        );

      case RoutesName.incident:
        return MaterialPageRoute(
          builder: (BuildContext context) => IncidentView(),
        );

      case RoutesName.feedback:
        return MaterialPageRoute(
          builder: (BuildContext context) => FeedbackView(),
        );

      case RoutesName.progress_notes:
        return MaterialPageRoute(
          builder: (BuildContext context) => ProgressNotesView(),
        );

      case RoutesName.progress:
        return MaterialPageRoute(
          builder: (BuildContext context) => ProgressView(),
        );

      case RoutesName.shif_report:
        return MaterialPageRoute(
          builder: (BuildContext context) => ShiftReportView(),
        );

      case RoutesName.client_profile:
        return MaterialPageRoute(
          builder: (BuildContext context) => ClientProfileView(),
        );
      case RoutesName.client_profile_documents:
        return MaterialPageRoute(
          builder: (BuildContext context) => ClientProfileDocumentsView(),
        );

      case RoutesName.client_profile_Goal:
        return MaterialPageRoute(
          builder: (BuildContext context) => ClientProfileGoalView(),
        );

      case RoutesName.unavailability:
        return MaterialPageRoute(
          builder: (BuildContext context) => UnavailabilityView(),
        );

      case RoutesName.readnotification:
        return MaterialPageRoute(
          builder: (BuildContext context) => ReadNotificationView(),
        );
      case RoutesName.unreadnotification:
        return MaterialPageRoute(
          builder: (BuildContext context) => UnReadNotificationView(),
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
