import 'package:flutter/material.dart';

class ReadNotificationView extends StatefulWidget {
  const ReadNotificationView({super.key});

  @override
  State<ReadNotificationView> createState() => _ReadNotificationViewState();
}

class _ReadNotificationViewState extends State<ReadNotificationView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Read Notification"),
        ],
      ),
    );
  }
}
