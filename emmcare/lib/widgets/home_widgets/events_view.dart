import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.buttonColor,
                backgroundImage: NetworkImage(""),
              ),
              title: Text(
                "**SHIFT REPORT .......**...",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    overflow: TextOverflow.ellipsis),
              ),
              subtitle: Text(
                "notes",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        );
      },
    );
  }
}
