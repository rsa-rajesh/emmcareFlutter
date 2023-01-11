import 'package:emmcare/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text(
            "My Notification",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.check_box),
            ),
          ],
        ),
        body: Column(
          children: [],
        ),
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
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
