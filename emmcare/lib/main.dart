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
import 'package:emmcare/view_model/feedback_view_view_model.dart';
import 'package:emmcare/view_model/home_view_view_model.dart';
import 'package:emmcare/view_model/incident_view_view_model.dart';
import 'package:emmcare/view_model/instruction_view_view_model.dart';
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
import 'firebase_options.dart';
import 'view_model/services/local_notification_services.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.subscribeToTopic('emmccare');
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();

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
        ChangeNotifierProvider(create: (_) => InstructionViewViewModel()),
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
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
