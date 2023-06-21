import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view/home_view.dart';

class InstructionView extends StatefulWidget {
  final String instructionReceived;
  const InstructionView({
    Key? key,
    required this.instructionReceived,
  }) : super(key: key);
  @override
  State<InstructionView> createState() => _InstructionViewState();
}

class _InstructionViewState extends State<InstructionView> {
  @override
  void initState() {
    super.initState();
    getClientName();
  }

  String? cltName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        title: Text(cltName!),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: true,
      ),
      body: checkInstruction(widget.instructionReceived),
    );
  }

  Future<void> getClientName() async {
    final sharedpref = await SharedPreferences.getInstance();

    setState(() {
      cltName = sharedpref.getString(HomeViewState.KEYCLIENTNAME)!;
    });
  }

  checkInstruction(instru) {
    if (instru == null) {
      return Center(
          child: Text(
        "No Instruction Available!",
        style: TextStyle(fontSize: 20),
      ));
    } else {
      return Card(
        child: ListTile(
          title: HtmlWidget(
            instru,
          ),
        ),
      );
    }
  }
}
