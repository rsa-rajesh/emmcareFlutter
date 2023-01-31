import 'package:emmcare/data/response/status.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/widgets/home_widgets/client_detail_view.dart';
import 'package:emmcare/view_model/home_view_view_model.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
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

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Shared prefs keys.
  static String KEYCLIENTID = "client_Id";
  static String KEYCLIENTNAME = "client_Name";
  static String KEYCLIENTAVATAR = "client_Avatar";
  static String KEYCLIENTLAT = "client_Lat";
  static String KEYCLIENTLog = "client_Log";
  // Shared prefs keys.

  // Calendar controller and event list.
  final _calendarControllerCustom =
      AdvancedCalendarController.custom(DateTime.now());
  final List<DateTime> events = [DateTime.now(), DateTime(0000, 10, 10)];
  // Calendar controller and event list.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentMonth + "\t" + currentYear),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pushAndRemoveUntil(
        //           context,
        //           MaterialPageRoute(builder: (context) => HomeView()),
        //           (Route<dynamic> route) => false,
        //         );
        //       },
        //       icon: Icon(Icons.refresh)),
        // ],
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
            labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            onTap: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: ChangeNotifierProvider<HomeViewViewModel>(
          create: (BuildContext context) => homeViewViewModel,
          child: Consumer<HomeViewViewModel>(
            builder: (context, value, _) {
              switch (value.clientList.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.ERROR:
                  return AlertDialog(
                    icon: Icon(Icons.error_rounded, size: 30),
                    title: Text(
                      value.clientList.message.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              refresh();
                            },
                            child: Text(
                              'Refresh',
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            child: Text('Abort'),
                          ),
                        ],
                      )
                    ],
                  );

                case Status.COMPLETED:
                  return Column(
                    children: [
                      Theme(
                        data: ThemeData.light().copyWith(
                          textTheme: ThemeData.light().textTheme.copyWith(
                                subtitle1: ThemeData.light()
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 12,
                                    ),
                                bodyText1: ThemeData.light()
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                bodyText2: ThemeData.light()
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 10,
                                      color: Colors.black87,
                                    ),
                              ),
                          primaryColor: Colors.blueAccent,
                          highlightColor: Colors.yellow,
                          disabledColor: Colors.green,
                        ),
                        child: AdvancedCalendar(
                          controller: _calendarControllerCustom,
                          events: events,
                          weekLineHeight: 48.0,
                          startWeekDay: 0,
                          innerDot: true,
                          keepLineSize: true,
                          calendarTextStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.3105,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      //
                      //

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: ListView.builder(
                            itemCount: value.clientList.data!.clients!.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                                value.clientList.data!
                                                    .clients![index].number
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                value.clientList.data!
                                                    .clients![index].day
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: InkWell(
                                          onTap: () async {
                                            int? clientId = value.clientList
                                                .data!.clients![index].id;
                                            String? clientName = value
                                                .clientList
                                                .data!
                                                .clients![index]
                                                .name;
                                            String? clientAvatar = value
                                                .clientList
                                                .data!
                                                .clients![index]
                                                .avatar;
                                            String? clientLat = value
                                                .clientList
                                                .data!
                                                .clients![index]
                                                .address!
                                                .geo!
                                                .lat;
                                            String? clientLog = value
                                                .clientList
                                                .data!
                                                .clients![index]
                                                .address!
                                                .geo!
                                                .lng;

                                            final sharedprefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            sharedprefs.setInt(
                                                KEYCLIENTID, clientId!);
                                            setState(() {
                                              sharedprefs.getInt(KEYCLIENTID);
                                            });

                                            sharedprefs.setString(
                                                KEYCLIENTNAME, clientName!);
                                            setState(() {
                                              sharedprefs
                                                  .getString(KEYCLIENTNAME);
                                            });

                                            sharedprefs.setString(
                                                KEYCLIENTAVATAR, clientAvatar!);
                                            setState(() {
                                              sharedprefs
                                                  .getString(KEYCLIENTAVATAR);
                                            });

                                            sharedprefs.setString(
                                                KEYCLIENTLAT, clientLat!);
                                            setState(() {
                                              sharedprefs
                                                  .getString(KEYCLIENTLAT);
                                            });

                                            sharedprefs.setString(
                                                KEYCLIENTLog, clientLog!);
                                            setState(() {
                                              sharedprefs
                                                  .getString(KEYCLIENTLog);
                                            });

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ClientDetailView(),

                                                // Pass the arguments as part of the RouteSettings. The
                                                // DetailScreen reads the arguments from these settings.
                                                settings: RouteSettings(
                                                  arguments: value.clientList
                                                      .data!.clients![index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            child: Column(children: [
                                              ListTile(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        12, 0, 12, 0),
                                                leading: Text(
                                                  value.clientList.data!
                                                      .clients![index].time
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                trailing: Text(
                                                  value.clientList.data!
                                                      .clients![index].purpose
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              ListTile(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        12, 0, 12, 0),
                                                title: Text(
                                                  value.clientList.data!
                                                      .clients![index].name
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                subtitle: Text(
                                                  value
                                                          .clientList
                                                          .data!
                                                          .clients![index]
                                                          .address!
                                                          .street
                                                          .toString() +
                                                      "," +
                                                      value
                                                          .clientList
                                                          .data!
                                                          .clients![index]
                                                          .address!
                                                          .suite
                                                          .toString() +
                                                      "," +
                                                      value
                                                          .clientList
                                                          .data!
                                                          .clients![index]
                                                          .address!
                                                          .zipcode
                                                          .toString() +
                                                      "," +
                                                      value
                                                          .clientList
                                                          .data!
                                                          .clients![index]
                                                          .address!
                                                          .city
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              ListTile(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        12, 0, 12, 0),
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    value.clientList.data!
                                                        .clients![index].avatar
                                                        .toString(),
                                                  ),
                                                ),
                                                trailing: Text(
                                                  value.clientList.data!
                                                      .clients![index].status
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ]),
                                          ))),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );

                default:
                  return Container(); // just to satisfy flutter analyzer
              }
            },
          ),
        ),
      ),
      drawer: NavigationDrawer(),
    );
  }

  Future<void> refresh() async {
    setState(() {
      homeViewViewModel.fetchClientListApi();
    });
  }
}
