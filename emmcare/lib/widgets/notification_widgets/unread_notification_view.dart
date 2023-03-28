import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/unread_notification_model.dart';
import '../../model/user_model.dart';
import '../../res/app_url.dart';
import '../../view_model/mark_notification_seen_view_model.dart';
import '../../view_model/user_view_view_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class UnReadNotificationView extends StatefulWidget {
  UnReadNotificationView({Key? key}) : super(key: key);

  @override
  State<UnReadNotificationView> createState() => UnReadNotificationViewState();
}

class UnReadNotificationViewState extends State<UnReadNotificationView> {
  MarkNotificationSeenViewModel markNotificationSeenViewViewModel =
      MarkNotificationSeenViewModel();
  static String KEYNOTIFICATIONID = "notification_Id";
  List<Result> result = [];
  ScrollController scrollController = ScrollController();
  bool loading = true;
  int offset = 1;

  @override
  void initState() {
    super.initState();
    fetchData(offset);
    handleNext();
  }

  void fetchData(page) async {
    setState(() {
      loading = true;
    });
    String token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });
    await Future.delayed(Duration(microseconds: 1));

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    bool is_seen = false;
    var response = await http.get(
      Uri.parse(
        AppUrl.getNotification(page, is_seen),
      ),
      headers: requestHeaders,
    );
    //
    //
    print(response);
    print(AppUrl.getNotification(page, is_seen));
    //
    //

    setState(() {
      var data = json.decode(response.body);
      UnReadNotificationModel modelClass =
          UnReadNotificationModel.fromJson(data);
      result = result + modelClass.results;
    });

    int localOffset = offset + 1;
    setState(() {
      result;
      loading = false;
      offset = localOffset;
    });
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        fetchData(offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (result.length == 0) {
      return Center(
          child: Text(
        "No Unread Notifications!",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ));
    } else {
      return Scaffold(
        body: ListView.builder(
          controller: scrollController,
          itemCount: result.length + 1,
          itemBuilder: (context, index) {
            if (index == result.length) {
              return loading
                  ? Container()
                  : Container(
                      // height: 200,
                      // child:  Center(
                      //   child: CircularProgressIndicator(
                      //     strokeWidth: 4,
                      //   ),
                      // ),
                      );
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Slidable(
                key: ValueKey(0),
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {}),
                  dragDismissible: false,

                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        int? notificaionId = result[index].id;
                        final sharedprefs =
                            await SharedPreferences.getInstance();
                        sharedprefs.setInt(KEYNOTIFICATIONID, notificaionId);
                        setState(() {
                          sharedprefs.getInt(KEYNOTIFICATIONID);
                        });
                        markNotificationSeenViewViewModel.markSeen(context);
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                            child: Text(
                              timeAgoCustom(
                                DateTime.parse(
                                  result[index].createdAt.toString(),
                                ),
                              ),
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.mark_as_unread),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    result[index].subject.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      result[index]
                                          .message
                                          .toString()
                                          .replaceAll(RegExp(' +'), ' '),
                                      style: TextStyle(fontSize: 12)),
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
        ),
      );
    }
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
