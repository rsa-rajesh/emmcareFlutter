import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:emmcare/widgets/home_widgets/details_view/client_profile_view/client_profile_sub_views/client_profile_goal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'client_profile_sub_views/client_profile_documents.dart';

class ClientProfileView extends StatefulWidget {
  @override
  ClientProfileViewState createState() => ClientProfileViewState();
}

class ClientProfileViewState extends State<ClientProfileView> {
  @override
  void initState() {
    super.initState();

    // Step:1
    //
    getClientName();
    getClientAvatar();
  }

  // Step:2
  String? cltName;
  String? cltAvatar;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            cltName!,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.appBarColor,
        ),
        body: Column(
          children: <Widget>[
            // construct the profile details widget here
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                    child: ClipOval(
                      child: Image.network(
                          "https://api.emmcare.pwnbot.io" + cltAvatar!,
                          width: 58,
                          height: 58,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          color: Colors.white,
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        cltName!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // the tab bar with two items
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Colors.white,
                bottom: TabBar(
                  unselectedLabelColor: Colors.black87,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: "DOCUMENTS",
                    ),
                    Tab(
                      text: "GOAL",
                    )
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  ClientProfileDocumentsView(),
                  ClientProfileGoalView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Step:3
  //

  Future<void> getClientName() async {
    final sharedpref = await SharedPreferences.getInstance();

    setState(() {
      cltName = sharedpref.getString(HomeViewState.KEYCLIENTNAME)!;
    });
  }

  Future<void> getClientAvatar() async {
    final sharedpref = await SharedPreferences.getInstance();

    setState(() {
      cltAvatar = sharedpref.getString(HomeViewState.KEYCLIENTAVATAR)!;
    });
  }
}
