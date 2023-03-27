import 'package:emmcare/data/response/status.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/widgets/home_widgets/client_detail_view.dart';
import 'package:emmcare/view_model/home_view_view_model.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  // Device Token to send push notification
  String deviceTokenToSendPushNotification = "";
  // Device Token to send push notification

  @override
  void initState() {
    homeViewViewModel.fetchClientListApi(context);
    super.initState();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Shared prefs keys.
  static String KEYSHIFTID = "shift_Id";
  static String KEYCLIENTNAME = "client_Name";
  static String KEYCLIENTAVATAR = "client_Avatar";
  static String KEYCLIENTID = "client_Id";
  // Shared prefs keys.

  // Calendar controller and event list.
  final _calendarControllerCustom =
      AdvancedCalendarController.custom(DateTime.now());
  final List<DateTime> events = [DateTime.now(), DateTime(0000, 10, 10)];
  // Calendar controller and event list.

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();

    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        title: Text(currentMonth + "\t" + currentYear),
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
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.3125,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      //
                      //

                      Expanded(
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
                                      child: Wrap(
                                        direction: Axis.vertical,
                                        children: [
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
                                                  fontWeight: FontWeight.bold)),
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
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 7,
                                    child: InkWell(
                                        onTap: () async {
                                          int? shiftId = value.clientList.data!
                                              .clients![index].id;
                                          String? clientName = value.clientList
                                              .data!.clients![index].client;
                                          String? clientAvatar = value
                                              .clientList
                                              .data!
                                              .clients![index]
                                              .clientImg;
                                          int? clientId = value.clientList.data!
                                              .clients![index].clientId;

                                          final sharedprefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          sharedprefs.setInt(
                                              KEYSHIFTID, shiftId!);
                                          setState(() {
                                            sharedprefs.getInt(KEYSHIFTID);
                                          });

                                          sharedprefs.setString(
                                              KEYCLIENTNAME, clientName!);
                                          setState(() {
                                            sharedprefs
                                                .getString(KEYCLIENTNAME);
                                          });

                                          sharedprefs.setString(KEYCLIENTAVATAR,
                                              clientAvatar.toString());
                                          setState(() {
                                            sharedprefs
                                                .getString(KEYCLIENTAVATAR);
                                          });

                                          sharedprefs.setInt(
                                              KEYCLIENTID, clientId!);
                                          setState(() {
                                            sharedprefs.getInt(KEYCLIENTID);
                                          });

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ClientDetailView(),
                                              settings: RouteSettings(
                                                arguments: value.clientList
                                                    .data!.clients![index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 8.0, 12.0, 0.0),
                                          child: Card(
                                            child: Column(children: [
                                              ListTile(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        12, 0, 12, 0),
                                                leading: Wrap(
                                                  children: [
                                                    Text(
                                                      DateFormat.jm().format(
                                                        DateFormat("hh:mm:ss")
                                                            .parse(value
                                                                .clientList
                                                                .data!
                                                                .clients![index]
                                                                .shiftStartTime
                                                                .toString()),
                                                      ),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text("-"),
                                                    Text(
                                                      DateFormat.jm().format(
                                                        DateFormat("hh:mm:ss")
                                                            .parse(value
                                                                .clientList
                                                                .data!
                                                                .clients![index]
                                                                .shiftEndTime
                                                                .toString()),
                                                      ),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                trailing: Text(
                                                  value.clientList.data!
                                                      .clients![index].shiftType
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
                                                      .clients![index].client
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
                                                      .shiftFullAddress
                                                      .toString(),
                                                  // "," +
                                                  // value
                                                  //     .clientList
                                                  //     .data!
                                                  //     .clients![index]
                                                  //     .client!
                                                  //     .toString() +
                                                  // "," +
                                                  // value
                                                  //     .clientList
                                                  //     .data!
                                                  //     .clients![index]
                                                  //     .client
                                                  //     .toString() +
                                                  // "," +
                                                  // value
                                                  //     .clientList
                                                  //     .data!
                                                  //     .clients![index]
                                                  //     .client!
                                                  //     .toString(),
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
                                                      AppColors.buttonColor,
                                                  child: ClipOval(
                                                    child: Image.network(
                                                        "http://pwnbot-agecare-backend.clouds.nepalicloud.com" +
                                                            value
                                                                .clientList
                                                                .data!
                                                                .clients![index]
                                                                .clientImg
                                                                .toString(),
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                      return Icon(
                                                        Icons.person,
                                                        color: Colors.white,
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
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ]),
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
}
