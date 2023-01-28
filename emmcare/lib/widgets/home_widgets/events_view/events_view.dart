import 'package:emmcare/model/client_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  Widget build(BuildContext context) {
    final client_Detail = ModalRoute.of(context)!.settings.arguments as Clients;
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutesName.shif_report);
          },
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.buttonColor,
                backgroundImage: NetworkImage(client_Detail.avatar.toString()),
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
