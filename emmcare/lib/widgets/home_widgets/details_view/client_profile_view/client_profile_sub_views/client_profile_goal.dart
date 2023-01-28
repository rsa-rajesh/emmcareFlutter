import 'package:flutter/material.dart';

class ClientProfileGoalView extends StatefulWidget {
  const ClientProfileGoalView({super.key});

  @override
  State<ClientProfileGoalView> createState() => _ClientProfileGoalViewState();
}

class _ClientProfileGoalViewState extends State<ClientProfileGoalView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Goal"),
    );
  }
}
