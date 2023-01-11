import 'package:emmcare/Screens/about_screen.dart';
import 'package:emmcare/Screens/document_hub_screen.dart';
import 'package:emmcare/Screens/job_board_screen.dart';
import 'package:emmcare/Screens/my_schedule_screen.dart';
import 'package:emmcare/Screens/my_document_screen.dart';
import 'package:emmcare/Screens/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header
          buildHeader(),
          //
          //
          ListTile(
            leading: Icon(
              CupertinoIcons.bell_fill,
              color: Colors.black,
            ),
            title: Text(
              "NOTIFICATION",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.black),
            ),
            onTap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => NotificationScreen(),
            )),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.black,
            ),
            title: Text(
              "MY SCHEDULE",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.black),
            ),
            onTap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MyScheduleScreen(),
            )),
          ),
          ListTile(
            leading: Icon(
              Icons.business_center_outlined,
              color: Colors.black,
            ),
            title: Text(
              "JOB BOARD",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.black),
            ),
            onTap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => JobBoardScreen(),
            )),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.doc,
              color: Colors.black,
            ),
            title: Text(
              "MY DOCUMENTS",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.black),
            ),
            onTap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MyDocumentScreen(),
            )),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.folder,
              color: Colors.black,
            ),
            title: Text(
              "DOCUMENT HUB",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.black),
            ),
            onTap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => DocumentHubScreen(),
            )),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.info,
              color: Colors.black,
            ),
            title: Text(
              "ABOUT",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.black),
            ),
            onTap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AboutScreen(),
            )),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Switch(
              value: light,
              activeColor: Colors.blue,
              thumbColor: MaterialStatePropertyAll<Color>(Colors.white),
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  light = value;
                });
              },
            ),
            title: Text(
              "SHIFT REMINDER",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Expanded(child: Container()),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      label: Text(
                        "LOG OUT",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class buildHeader extends StatefulWidget {
  const buildHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<buildHeader> createState() => _buildHeaderState();
}

class _buildHeaderState extends State<buildHeader> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.shade700,
      child: Container(
        // color: Color.fromARGB(255, 23, 36, 59),
        color: Colors.blueGrey,
        padding: EdgeInsets.only(
            top: 50,
            // top: MediaQuery.of(context).padding.top,
            bottom: 24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  ExactAssetImage('assets/images/app_logo_white.png'),

              // backgroundImage: NetworkImage(
              //   "https://old.emmett-technique-hq.com/images/icons/icon-logo-emm-care-wh.jpg",
              // ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "EMMC Support Services",
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            Text(
              "EMMC Support Services",
              style: TextStyle(fontSize: 13, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
