// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  final String flag;
  const DemoScreen({
    Key? key,
    required this.flag,
  }) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.flag),
      ),
      body: Center(
        child: Text("Demo Screen!"),
      ),
    );
  }
}
