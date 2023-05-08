import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/view/login_view.dart';
import 'package:emmcare/view_model/user_view_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => NavDrawerState();
}

class NavDrawerState extends State<NavDrawer> {
  bool? isChecked;
  String obtainEmail = "";
  @override
  void initState() {
    loadBool();
    super.initState();
  }

  loadBool() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      isChecked = preferences.getBool('isChecked');
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
    saveBool() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool('isChecked', isChecked!);
      print(isChecked);
    }

    final userPreference = Provider.of<UserViewViewModel>(context);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header
          buildHeader(),
          //
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
            onTap: () {
              Navigator.pushReplacementNamed(context, RoutesName.home);
            },
          ),
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
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RoutesName.notification);
            },
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
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RoutesName.my_document);
            },
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
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RoutesName.document_hub);
            },
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
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RoutesName.about);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Switch(
              value: isChecked != null ? isChecked! : false,
              activeColor: Colors.green,
              thumbColor: MaterialStatePropertyAll<Color>(Colors.white),
              onChanged: (value) {
                setState(() {
                  isChecked = value;
                });
                saveBool();
              },
            ),
            title: Text(
              isChecked == true
                  ? "DISABLE NOTIFICATION"
                  : "ENABLE NOTIFICATION",
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
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return LoginView();
                          }), (r) {
                            return false;
                          });
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
                    ),
                  )
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
    super.initState();
    getEmail();
  }

  String obtainEmail = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.NavDrawerHeaderColor,
      padding: EdgeInsets.only(top: 50, bottom: 50),
      child: Column(
        children: [
          CircleAvatar(
            radius: 65,
            backgroundImage: ExactAssetImage('assets/images/pwnbot.png'),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              "EMMC Support Services",
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
          Text(
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
