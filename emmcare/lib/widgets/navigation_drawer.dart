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
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  margin: EdgeInsets.zero,
                  accountName: Text("",
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                  accountEmail: Center(
                    child: Text(
                      "rostermanagement@emmc.com.au",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  // currentAccountPicture: CircleAvatar(
                  //   backgroundImage: NetworkImage(""),
                  // ),
                )),
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
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
      ),
    );
  }
}
