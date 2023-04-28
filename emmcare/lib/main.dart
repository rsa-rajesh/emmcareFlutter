import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:emmcare/utils/routes/routes.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/view_model/Injury_view_view_model.dart';
import 'package:emmcare/view_model/auth_view_view_model.dart';
import 'package:emmcare/view_model/client_profile_document_view_view_model.dart';
import 'package:emmcare/view_model/client_profile_goal_view_view_model.dart';
import 'package:emmcare/view_model/clock_in_view_model.dart';
import 'package:emmcare/view_model/clock_out_view_model.dart';
import 'package:emmcare/view_model/document_hub_view_view_model.dart';
import 'package:emmcare/view_model/enquiry_view_view_model.dart';
import 'package:emmcare/view_model/events_view_view_moel.dart';
import 'package:emmcare/view_model/feedback_view_view_model.dart';
import 'package:emmcare/view_model/home_view_view_model.dart';
import 'package:emmcare/view_model/incident_view_view_model.dart';
import 'package:emmcare/view_model/mark_notification_all_seen_view_model.dart';
import 'package:emmcare/view_model/mark_notification_seen_view_model.dart';
import 'package:emmcare/view_model/my_document_view_view_model.dart';
import 'package:emmcare/view_model/progress_note_view_view_model.dart';
import 'package:emmcare/view_model/progress_view_view_model.dart';
import 'package:emmcare/view_model/sub_event_view_view_model.dart';
import 'package:emmcare/view_model/tasks_view_view_model.dart';
import 'package:emmcare/view_model/unavailability_create_view_view_model.dart';
import 'package:emmcare/view_model/user_view_view_model.dart';
import 'package:emmcare/view_model/warning_view_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.subscribeToTopic('push_notification_test');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewViewModel()),
        ChangeNotifierProvider(create: (_) => MyDocumentViewViewModel()),
        ChangeNotifierProvider(create: (_) => ProgressNoteViewModel()),
        ChangeNotifierProvider(create: (_) => FeedbackViewModel()),
        ChangeNotifierProvider(create: (_) => WarningViewModel()),
        ChangeNotifierProvider(create: (_) => IncidentViewModel()),
        ChangeNotifierProvider(create: (_) => EnquiryViewModel()),
        ChangeNotifierProvider(create: (_) => SubEventViewModel()),
        ChangeNotifierProvider(create: (_) => InjuryViewModel()),
        ChangeNotifierProvider(
            create: (_) => MarkNotificationAllSeenViewModel()),
        ChangeNotifierProvider(create: (_) => MarkNotificationSeenViewModel()),
        ChangeNotifierProvider(create: (_) => ProgressViewViewModel()),
        ChangeNotifierProvider(create: (_) => TasksViewViewModel()),
        ChangeNotifierProvider(create: (_) => UnavailabilityViewViewModel()),
        ChangeNotifierProvider(create: (_) => DocumentHubViewViewModel()),
        ChangeNotifierProvider(create: (_) => ClockInViewModel()),
        ChangeNotifierProvider(create: (_) => ClockOutViewModel()),
        ChangeNotifierProvider(
            create: (_) => ClientProfileDocumentViewViewModel()),
        ChangeNotifierProvider(create: (_) => ClientProfileGoalViewViewModel()),
        ChangeNotifierProvider(create: (_) => EventsViewViewModel()),
      ],
      child: MaterialApp(
        navigatorObservers: [ChuckerFlutter.navigatorObserver],
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
