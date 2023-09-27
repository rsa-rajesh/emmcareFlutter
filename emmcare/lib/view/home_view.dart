// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emmcare/data/response/status.dart';
import 'package:emmcare/model/client_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/view_model/home_view_view_model.dart';
import 'package:emmcare/view_model/services/notification_services.dart';
import 'package:emmcare/widgets/home_widgets/client_detail_view.dart';

class HomeView extends StatefulWidget {
  final Map arguments;
  HomeView({
    Key? key,
    required this.arguments,
  }) : super(key: key);
  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  // Shared prefs keys.
  static String KEYSHIFTID = "shift_Id";
  static String KEYCLIENTNAME = "client_Name";
  static String KEYCLIENTAVATAR = "client_Avatar";
  static String KEYCLIENTID = "client_Id";
  static String KEYSTAFFID = "staff_Id";
  static String KEYSTAFFNAME = "staff_Name";
  // Shared prefs keys.

  // Calendar controller and event list.
  final _calendarControllerCustom = AdvancedCalendarController.today();
  final List<DateTime> events = [];
  // Calendar controller and event list.

  final _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  NotificationServices notificationServices = NotificationServices();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  late double long;
  late double lat;

  @override
  void initState() {
    checkFlag(widget.arguments);
    super.initState();
    homeViewViewModel.fetchClientListApi(context);
    notificationServices.requestNotificationPermission();
    FlutterAppBadger.updateBadgeCount(0);
    checkGps();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
      if (haspermission) {
        setState(() {
          //refresh the UI
        });
        // getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
    setState(() {
      //refresh the UI
    });
  }

  @override
  Widget build(BuildContext context) {
    // refresh();
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        title: Text("Shift List"),
        centerTitle: true,
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
            onTap: () {
              Navigator.pushNamed(context, RoutesName.unavailability);
            },
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
                  return Stack(
                    children: [
                      Image.asset(
                        'assets/images/something_went_wrong.png',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const Positioned(
                        bottom: 230,
                        left: 150,
                        child: Text(
                          'Oh no!',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                              fontSize: 40),
                        ),
                      ),
                      const Positioned(
                        bottom: 170,
                        left: 100,
                        child: Text(
                          'Something went wrong,\nplease try again.',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        left: 50,
                        right: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: StadiumBorder(),
                                ),
                                onPressed: () {
                                  refresh();
                                },
                                child: Text(
                                  'Try Again',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: StadiumBorder()),
                                onPressed: () {
                                  SystemChannels.platform
                                      .invokeMethod('SystemNavigator.pop');
                                },
                                child: Text('Abort'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );

                case Status.COMPLETED:
                  addEvents(value.clientList.data);
                  return Column(
                    children: [
                      Theme(
                        data: ThemeData.light().copyWith(
                          textTheme: ThemeData.light().textTheme.copyWith(
                                titleMedium: ThemeData.light()
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                                bodyLarge: ThemeData.light()
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                bodyMedium: ThemeData.light()
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                              ),
                          primaryColor: Colors.green[900],
                          highlightColor: Colors.green[200],
                          disabledColor: Colors.grey[300],
                        ),
                        child: AdvancedCalendar(
                          onHorizontalDrag: (p0) {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("calender Slide")));
                          },
                          onDateChanged: (p0) {
                            _scrollToIndex(
                                getIndex(p0, value.clientList.data!.clients!));
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(p0.toString())));
                          },
                          controller: _calendarControllerCustom,
                          events: events,
                          preloadWeekViewAmount: 20,
                          weekLineHeight: 48.0,
                          startWeekDay: 0,
                          innerDot: true,
                          keepLineSize: true,
                          calendarTextStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.3125,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      value.clientList.data!.clients!.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No Shift!",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: StadiumBorder(),
                                    ),
                                    onPressed: () {
                                      refresh();
                                    },
                                    child: Text(
                                      'Refresh',
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount:
                                    value.clientList.data!.clients!.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 80,
                                          width: 40,
                                          child: Center(
                                            child: Wrap(
                                              direction: Axis.vertical,
                                              children: [
                                                Text(
                                                    DateFormat.MMM().format(
                                                        DateTime.parse(value
                                                            .clientList
                                                            .data!
                                                            .clients![index]
                                                            .shiftStartDate
                                                            .toString())),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    DateFormat.d().format(
                                                        DateTime.parse(value
                                                            .clientList
                                                            .data!
                                                            .clients![index]
                                                            .shiftStartDate
                                                            .toString())),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    DateFormat.E().format(
                                                        DateTime.parse(value
                                                            .clientList
                                                            .data!
                                                            .clients![index]
                                                            .shiftStartDate
                                                            .toString())),
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
                                          flex: 7,
                                          child: InkWell(
                                              onTap: () async {
                                                int? shiftId = value.clientList
                                                    .data!.clients![index].id;
                                                String? clientName = value
                                                    .clientList
                                                    .data!
                                                    .clients![index]
                                                    .client;
                                                String? clientAvatar = value
                                                    .clientList
                                                    .data!
                                                    .clients![index]
                                                    .clientImg;
                                                int? clientId = value
                                                    .clientList
                                                    .data!
                                                    .clients![index]
                                                    .clientId;
                                                int? staffId = value
                                                    .clientList
                                                    .data!
                                                    .clients![index]
                                                    .staffId;
                                                String? staffName = value
                                                    .clientList
                                                    .data!
                                                    .clients![index]
                                                    .staff;

                                                final sharedprefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                sharedprefs.setInt(
                                                    KEYSHIFTID, shiftId!);
                                                setState(() {
                                                  sharedprefs
                                                      .getInt(KEYSHIFTID);
                                                });

                                                sharedprefs.setString(
                                                    KEYCLIENTNAME, clientName!);
                                                setState(() {
                                                  sharedprefs
                                                      .getString(KEYCLIENTNAME);
                                                });

                                                sharedprefs.setString(
                                                    KEYCLIENTAVATAR,
                                                    clientAvatar.toString());
                                                setState(() {
                                                  sharedprefs.getString(
                                                      KEYCLIENTAVATAR);
                                                });

                                                sharedprefs.setInt(
                                                    KEYCLIENTID, clientId!);
                                                setState(() {
                                                  sharedprefs
                                                      .getInt(KEYCLIENTID);
                                                });

                                                sharedprefs.setInt(
                                                    KEYSTAFFID, staffId!);
                                                setState(() {
                                                  sharedprefs
                                                      .getInt(KEYSTAFFID);
                                                });

                                                sharedprefs.setString(
                                                    KEYSTAFFNAME, staffName!);
                                                setState(() {
                                                  sharedprefs
                                                      .getString(KEYSTAFFNAME);
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ClientDetailView(),
                                                    settings: RouteSettings(
                                                      arguments: value
                                                          .clientList
                                                          .data!
                                                          .clients![index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0.0, 8.0, 12.0, 0.0),
                                                child: Container(
                                                  height: 200,
                                                  child: Card(
                                                    color: getBackgroundColor(
                                                        value
                                                            .clientList
                                                            .data!
                                                            .clients![index]
                                                            .shiftStartDate
                                                            .toString()),
                                                    child: Column(children: [
                                                      ListTile(
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                12, 0, 12, 0),
                                                        leading: Wrap(
                                                          children: [
                                                            Text(
                                                              DateFormat.jm()
                                                                  .format(
                                                                DateFormat("hh:mm:ss").parse(value
                                                                    .clientList
                                                                    .data!
                                                                    .clients![
                                                                        index]
                                                                    .shiftStartTime
                                                                    .toString()),
                                                              ),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text("-"),
                                                            Text(
                                                              DateFormat.jm()
                                                                  .format(
                                                                DateFormat("hh:mm:ss").parse(value
                                                                    .clientList
                                                                    .data!
                                                                    .clients![
                                                                        index]
                                                                    .shiftEndTime
                                                                    .toString()),
                                                              ),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: Text(
                                                          value
                                                              .clientList
                                                              .data!
                                                              .clients![index]
                                                              .shiftType
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      ListTile(
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                12, 0, 12, 0),
                                                        title: Text(
                                                          value
                                                              .clientList
                                                              .data!
                                                              .clients![index]
                                                              .client
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                        subtitle: Text(
                                                          value
                                                              .clientList
                                                              .data!
                                                              .clients![index]
                                                              .shiftFullAddress
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      ListTile(
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                12, 0, 12, 0),
                                                        leading: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.black,
                                                          radius: 20,
                                                          child: ClipOval(
                                                            child: Image.network(
                                                                "https://api.emmcare.pwnbot.io" +
                                                                    value
                                                                        .clientList
                                                                        .data!
                                                                        .clients![
                                                                            index]
                                                                        .clientImg
                                                                        .toString(),
                                                                width: 39,
                                                                height: 39,
                                                                fit:
                                                                    BoxFit.fill,
                                                                errorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                              return Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .white,
                                                              );
                                                            }),
                                                          ),
                                                        ),
                                                        trailing: Text(
                                                          value
                                                              .clientList
                                                              .data!
                                                              .clients![index]
                                                              .shiftStatus
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                              ))),
                                    ],
                                  );
                                },
                              ),
                            ),
                    ],
                  );

                default:
                  return Container();
              }
            },
          ),
        ),
      ),
      drawer: NavDrawer(),
    );
  }

  Future<void> refresh() async {
    setState(() {
      homeViewViewModel.fetchClientListApi(context);
    });
  }

  void addEvents(ClientModel? data) {
    for (var date in data!.clients!) {
      events.add(DateTime.parse(date.shiftStartDate!));
    }
  }

  // Define the function that scroll to an item
  void _scrollToIndex(index) {
    double height = 200;
    _scrollController.animateTo(
      height * index,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeIn,
    );
  }

  getIndex(DateTime p0, List<Clients> clients) {
    int index = 0;
    for (var element in clients) {
      if (element.shiftStartDate == p0.toString().split(" ")[0]) {
        return index;
      }
      index++;
    }
    return 0;
  }

  dynamic checkFlag(Map arguments) {
    if (arguments["flag"] == "New shift") {
      return Navigator.pushReplacementNamed(
        context,
        RoutesName.home,
      );
    } else if (arguments["flag"] == "unread") {
      return Navigator.pushReplacementNamed(
        context,
        RoutesName.notification,
      );
    } else if (arguments["flag"] == "records") {
      return Navigator.pushReplacementNamed(
        context,
        RoutesName.my_document,
      );
    } else if (arguments["flag"] == "c_profile") {
      return Navigator.pushReplacementNamed(
        context,
        RoutesName.document_hub,
      );
    }
    //  else if (arguments["flag"] == "client_detail") {
    //   return Navigator.pushReplacementNamed(
    //     context,
    //     RoutesName.client_detail,
    //   );
    // }
    else {
      return null;
    }
  }

  getBackgroundColor(String string) {
    DateTime date = DateFormat("yyyy-MM-dd").parse(string);

    DateTime now = new DateTime.now();
    DateTime date2 = new DateTime(now.year, now.month, now.day);

    if (date == date2) {
      return Color.fromARGB(255, 199, 243, 203);
    } else {
      return Color.fromARGB(255, 255, 255, 255);
    }
  }
}
