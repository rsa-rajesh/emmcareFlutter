import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:emmcare/widgets/notification_widgets/read_notification_view.dart';
import 'package:emmcare/widgets/notification_widgets/unread_notification_view.dart';
import 'package:flutter/material.dart';
import '../res/components/alert_dialog_box.dart';
import '../view_model/mark_notification_all_seen_view_model.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  MarkNotificationAllSeenViewModel markNotificationAllSeenViewViewModel =
      MarkNotificationAllSeenViewModel();
  int _selectedIndex = 0;

  // List of Notificaiton Widgets.
  List<Widget> _pages = <Widget>[
    UnReadNotificationView(),
    ReadNotificationView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        title: Text(
          "My Alert",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [getAction(_selectedIndex)],
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

  getAction(int selectedIndex) {
    if (selectedIndex == 0) {
      return IconButton(
        onPressed: () {
          // Show confirm dialog when clicked on widget
          showConfirmDialog(
            context,
            "Mark Notification Seen",
            "Do you want to mark all notification as seen?",
            "Confirm",
            "Cancel",
            () {
              // do stuff when clicked on Confirm
              markNotificationAllSeenViewViewModel.markAllSeen(context);
              setState(() {});
            },
          );
        },
        icon: Icon(Icons.check_box),
      );
    } else {
      return Text('');
    }
  }
}
