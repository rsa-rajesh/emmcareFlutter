import 'package:flutter/material.dart';

class ClientProfileDetailView extends StatefulWidget {
  const ClientProfileDetailView({super.key});

  @override
  State<ClientProfileDetailView> createState() =>
      _ClientProfileDetailViewState();
}

class _ClientProfileDetailViewState extends State<ClientProfileDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Detail"),
    );
  }
}
