import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/response/status.dart';
import 'package:intl/intl.dart';
import '../../res/colors.dart';
import '../../view_model/mark_notification_seen_view_model.dart';
import '../../view_model/unread_notification_view_view_model.dart';

class UnReadNotificationView extends StatefulWidget {
  UnReadNotificationView({Key? key}) : super(key: key);
  @override
  State<UnReadNotificationView> createState() => UnReadNotificationViewState();
}

class UnReadNotificationViewState extends State<UnReadNotificationView> {
  int page = 1;
  static String KEYNOTIFICATIONID = "notification_Id";
  UnReadNotificationViewViewModel unReadNotificationViewViewModel =
      UnReadNotificationViewViewModel();
  MarkNotificationSeenViewModel markNotificationSeenViewModel =
      MarkNotificationSeenViewModel();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    unReadNotificationViewViewModel.fetchUnReadNotificationListApi(page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return refresh();
        },
        child: ChangeNotifierProvider<UnReadNotificationViewViewModel>(
          create: (BuildContext context) => unReadNotificationViewViewModel,
          child: Consumer<UnReadNotificationViewViewModel>(
            builder: (context, value, _) {
              switch (value.unReadNotificationList.status) {
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
                        left: 130,
                        right: 130,
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
                    ],
                  );
                case Status.COMPLETED:
                  return value.unReadNotificationList.data!.results!.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Unread Alerts!",
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
                      : ListView.builder(
                          itemCount: value
                              .unReadNotificationList.data!.results!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Slidable(
                                key: ValueKey(1),
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  // A pane can dismiss the Slidable.
                                  dismissible:
                                      DismissiblePane(onDismissed: () {}),
                                  dragDismissible: false,

                                  children: [
                                    SlidableAction(
                                      onPressed: (context) async {
                                        int? notificaionId = value
                                            .unReadNotificationList
                                            .data!
                                            .results![index]
                                            .id;
                                        final sharedprefs =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedprefs.setInt(
                                            KEYNOTIFICATIONID, notificaionId);
                                        setState(
                                          () {
                                            sharedprefs
                                                .getInt(KEYNOTIFICATIONID);
                                          },
                                        );

                                        markNotificationSeenViewModel
                                            .markSeen(context);
                                        DismissiblePane(
                                          onDismissed: () {},
                                        );
                                      },
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.check_circle,
                                      label: 'Mark as read',
                                    ),
                                  ],
                                ),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 8, 8, 0),
                                            child: Text(
                                              timeAgoCustom(
                                                DateTime.parse(
                                                  value
                                                      .unReadNotificationList
                                                      .data!
                                                      .results![index]
                                                      .createdAt
                                                      .toString(),
                                                ),
                                              ),
                                              style: TextStyle(
                                                  color: Colors.redAccent),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 0, 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.mark_as_unread),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    value
                                                        .unReadNotificationList
                                                        .data!
                                                        .results![index]
                                                        .subject
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      value
                                                          .unReadNotificationList
                                                          .data!
                                                          .results![index]
                                                          .message
                                                          .toString()
                                                          .replaceAll(
                                                              RegExp(' +'),
                                                              ' '),
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> refresh() async {
    setState(() {
      unReadNotificationViewViewModel.fetchUnReadNotificationListApi(page);
    });
  }

  String timeAgoCustom(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${DateFormat.E().add_jm().format(d)}";
    }
    if (diff.inHours > 0) {
      return "Today ${DateFormat('jm').format(d)}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }
}
