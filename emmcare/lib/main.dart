import 'package:emmcare/utils/routes/routes.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/view_model/auth_view_view_model.dart';
import 'package:emmcare/view_model/ducument_hub_view_view_model.dart';
import 'package:emmcare/view_model/home_view_view_model.dart';
import 'package:emmcare/view_model/my_document_view_view_model.dart';
import 'package:emmcare/view_model/user_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
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
        ChangeNotifierProvider(create: (_) => MyDocumentViewViewModel()),
        ChangeNotifierProvider(create: (_) => DocumentHubViewViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewViewModel()),
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
