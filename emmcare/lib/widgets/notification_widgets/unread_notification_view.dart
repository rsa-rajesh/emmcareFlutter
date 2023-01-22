import 'package:flutter/material.dart';

class UnReadNotificationView extends StatefulWidget {
  const UnReadNotificationView({super.key});

  @override
  State<UnReadNotificationView> createState() => _UnReadNotificationViewState();
}

class _UnReadNotificationViewState extends State<UnReadNotificationView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Unread Notificaiton"),
        ],
      ),
    );
  }
}
