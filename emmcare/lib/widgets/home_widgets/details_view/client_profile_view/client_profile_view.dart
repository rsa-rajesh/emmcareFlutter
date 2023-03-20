import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:emmcare/widgets/home_widgets/details_view/client_profile_view/client_profile_sub_views/client_profile_detail.dart';
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
  //
  int? cltId;
  String? cltName;
  String? cltAvatar;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            cltName!,
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
                    backgroundColor: AppColors.buttonColor,
                    radius: 30,
                    child: ClipOval(
                      child: Image.network(
                          "http://pwnbot-agecare-backend.clouds.nepalicloud.com" +
                              cltAvatar!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          color: Colors.white,
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cltName!,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
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
                      text: "DETAIL",
                    ),
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
                  // first tab bar view widget
                  ClientProfileDetailView(),

                  // second tab bar viiew widget
                  ClientProfileDocumentsView(),

                  // second tab bar viiew widget
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
