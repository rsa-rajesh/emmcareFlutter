import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';

class ShiftReportView extends StatefulWidget {
  const ShiftReportView({super.key});

  @override
  State<ShiftReportView> createState() => _ShiftReportViewState();
}

class _ShiftReportViewState extends State<ShiftReportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Card(child: Text("Shif Report")),
      ),
    );
  }
}
