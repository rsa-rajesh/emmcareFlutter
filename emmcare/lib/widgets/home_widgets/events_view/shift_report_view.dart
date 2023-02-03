import 'package:emmcare/model/events_model.dart';
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
    final event = ModalRoute.of(context)!.settings.arguments as Events;
    return Scaffold(
      appBar: AppBar(
        title: Text(event.heading.toString()),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(event.clientImage.toString())),
                  title: Text(
                    "${event.supporter.toString()} added a Note for ${event.clientName.toString()}  @ ${event.date.toString()}  ${event.time.toString()}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(event.shiftImage.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Text(
                    event.title.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Text(
                    event.desc.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
