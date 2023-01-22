import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:emmcare/widgets/notification_widgets/read_notification_view.dart';
import 'package:emmcare/widgets/notification_widgets/unread_notification_view.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  int _selectedIndex = 0;

  // List of Notificaiton Widgets.
  List<Widget> _pages = <Widget>[
    ReadNotificationView(),
    UnReadNotificationView(),
  ];
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        title: Text(
          "My Notification",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check_box),
          ),
        ],
      ),

      // Default view of Notification widget.
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      //

      bottomNavigationBar: BottomNavigationBar(
        iconSize: 26,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_outlined,
              color: Color.fromARGB(255, 23, 36, 59),
            ),
            label: "UNREAD",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              color: Color.fromARGB(255, 23, 36, 59),
              Icons.check_box_sharp,
            ),
            label: "READ",
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
