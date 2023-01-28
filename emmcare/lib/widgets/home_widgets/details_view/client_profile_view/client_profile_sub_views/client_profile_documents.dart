import 'package:flutter/material.dart';

class ClientProfileDocumentView extends StatefulWidget {
  const ClientProfileDocumentView({super.key});

  @override
  State<ClientProfileDocumentView> createState() =>
      _ClientProfileDocumentViewState();
}

class _ClientProfileDocumentViewState extends State<ClientProfileDocumentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Documents"),
    );
  }
}
