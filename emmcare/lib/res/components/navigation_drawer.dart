import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/view/login_view.dart';
import 'package:emmcare/view_model/user_view_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool light = true;

  String obtainEmail = "";
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewViewModel>(context);
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
            onTap: () => Navigator.pushNamed(context, RoutesName.notification),
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
            onTap: () => Navigator.pushNamed(context, RoutesName.home),
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
            onTap: () => Navigator.pushNamed(context, RoutesName.job_board),
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
            onTap: () => Navigator.pushNamed(context, RoutesName.my_document),
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
            onTap: () => Navigator.pushNamed(context, RoutesName.document_hub),
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
            onTap: () => Navigator.pushNamed(context, RoutesName.about),
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
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        userPreference.remove().then(
                          (value) {
                            Navigator.pushNamed(context, RoutesName.login);
                          },
                        );
                      },
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
  }

  String obtainEmail = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color.fromARGB(255, 23, 36, 59),
      color: AppColors.NavDrawerHeaderColor,
      padding: EdgeInsets.only(
          top: 35,
          // top: MediaQuery.of(context).padding.top,
          bottom: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage:
                ExactAssetImage('assets/images/app_logo_white.png'),

            // backgroundImage: NetworkImage(
            //   "",
            // ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "EMMC Support Services",
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          Text(
            // "rostermanagement@emmc.com.au",
            obtainEmail,
            style: TextStyle(fontSize: 13, color: Colors.white),
          )
        ],
      ),
    );
  }

  Future<void> getEmail() async {
    final sharedpref = await SharedPreferences.getInstance();

    setState(() {
      obtainEmail = sharedpref.getString(LoginViewState.KEYEMAIL)!;
    });
  }
}
