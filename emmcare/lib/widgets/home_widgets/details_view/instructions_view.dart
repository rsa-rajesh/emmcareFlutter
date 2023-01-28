import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';

class InstructionView extends StatefulWidget {
  const InstructionView({super.key});

  @override
  State<InstructionView> createState() => _InstructionViewState();
}

class _InstructionViewState extends State<InstructionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Text("Instructions goes here."),
      ),
    );
  }
}
