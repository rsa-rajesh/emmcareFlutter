import 'package:emmcare/model/client_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/widgets/home_widgets/details_view/details_view.dart';
import 'package:emmcare/widgets/home_widgets/progress_view/progress_view.dart';
import 'package:emmcare/widgets/home_widgets/tasks_view.dart';
import 'package:flutter/material.dart';

import 'events_view/events_view.dart';

class ClientDetailView extends StatefulWidget {
  const ClientDetailView({
    super.key,
  });

  @override
  State<ClientDetailView> createState() => ClientDetailViewState();
}

class ClientDetailViewState extends State<ClientDetailView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Receiving the list of client from home view .
    final client_Detail = ModalRoute.of(context)!.settings.arguments as Clients;

    //

    List<Widget> _pages = <Widget>[
      DetailsView(),
      TasksView(),
      ProgressView(),
      EventsView(),
    ];

    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        title: Text(
          client_Detail.client.toString() +
              "-" +
              client_Detail.shiftType.toString(),
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        iconSize: 26,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              color: Color.fromARGB(255, 23, 36, 59),
            ),
            label: "DETAILS",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              color: Color.fromARGB(255, 23, 36, 59),
              Icons.list_outlined,
            ),
            label: "TASKS",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message_sharp,
              color: Color.fromARGB(255, 23, 36, 59),
            ),
            label: "PROGRESS",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              color: Color.fromARGB(255, 23, 36, 59),
              Icons.notifications,
            ),
            label: "EVENTS",
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
