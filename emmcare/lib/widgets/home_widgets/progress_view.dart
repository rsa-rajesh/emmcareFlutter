import 'package:flutter/material.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Progress"),
        ],
      ),
    );
  }
}
