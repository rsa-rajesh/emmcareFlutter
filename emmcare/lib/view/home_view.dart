import 'package:emmcare/data/response/status.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/widgets/home_widgets/client_detail_view.dart';
import 'package:emmcare/view_model/home_view_view_model.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  // App bar current Month and year.
  String currentMonth = DateFormat.LLL().format(DateTime.now());
  String currentYear = DateFormat("yyyy").format(DateTime.now());

  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    homeViewViewModel.fetchClientListApi();
    super.initState();
  }

  static String KEYCLIENTID = "client_Id";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(currentMonth),
          SizedBox(width: 5),
          Text(currentYear),
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
        ],
        backgroundColor: AppColors.appBarColor,
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor:
            AppColors.floatingActionButtonColor, //background color of button
        buttonSize: Size(56, 56), //button size
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,

        shape: CircleBorder(), //shape of button

        children: [
          SpeedDialChild(
            //speed dial child
            child: Icon(Icons.event_busy_rounded),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Add Unavailability',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {},
          ),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, _) {
            switch (value.clientList.status) {
              case Status.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case Status.ERROR:
                return Center(
                  child: Text(
                    value.clientList.message.toString(),
                  ),
                );

              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: value.clientList.data!.clients!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          int? clientId =
                              value.clientList.data!.clients![index].id;

                          final sharedprefs =
                              await SharedPreferences.getInstance();

                          sharedprefs.setInt(KEYCLIENTID, clientId!);

                          setState(() {
                            sharedprefs.getInt(KEYCLIENTID);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientDetailView(),

                              // Pass the arguments as part of the RouteSettings. The
                              // DetailScreen reads the arguments from these settings.
                              settings: RouteSettings(
                                arguments:
                                    value.clientList.data!.clients![index],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 45),
                          child: Card(
                            child: Column(children: [
                              ListTile(
                                contentPadding:
                                    EdgeInsets.fromLTRB(18, 2, 18, 2),
                                leading: Text(
                                  value.clientList.data!.clients![index].time
                                      .toString(),
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                trailing: Text(
                                  value.clientList.data!.clients![index].purpose
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.fromLTRB(18, 2, 18, 2),
                                title: Text(
                                  value.clientList.data!.clients![index].name
                                      .toString(),
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                subtitle: Text(
                                  value.clientList.data!.clients![index]
                                          .address!.street
                                          .toString() +
                                      "," +
                                      value.clientList.data!.clients![index]
                                          .address!.suite
                                          .toString() +
                                      "," +
                                      value.clientList.data!.clients![index]
                                          .address!.zipcode
                                          .toString() +
                                      "," +
                                      value.clientList.data!.clients![index]
                                          .address!.city
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.fromLTRB(18, 2, 18, 2),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    value
                                        .clientList.data!.clients![index].avatar
                                        .toString(),
                                  ),
                                ),
                                trailing: Text(
                                  value.clientList.data!.clients![index].status
                                      .toString(),
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              )
                            ]),
                          ),
                        ));
                  },
                );

              default:
                return Container(); // just to satisfy flutter analyzer
            }
          },
        ),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
