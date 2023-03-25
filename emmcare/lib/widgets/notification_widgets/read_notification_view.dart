import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/read_notification_model.dart';
import '../../model/user_model.dart';
import '../../res/app_url.dart';
import '../../view_model/user_view_view_model.dart';
import 'package:intl/intl.dart';

class ReadNotificationView extends StatefulWidget {
  ReadNotificationView({Key? key}) : super(key: key);

  @override
  State<ReadNotificationView> createState() => _ReadNotificationViewState();
}

class _ReadNotificationViewState extends State<ReadNotificationView> {
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
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // var realtedUserType = decodedToken["role"];
    // var realtedUserId = decodedToken["user_id"];
    // var realtedUserType = "";
    // var realtedUserId = "";

    var response = await http.get(
      Uri.parse(
        AppUrl.getReadNotification(page),
      ),
      headers: requestHeaders,
    );
    //
    //
    print(response);
    print(AppUrl.getReadNotification(page));
    //
    //

    var data = json.decode(response.body);
    ReadNotificationModel modelClass = ReadNotificationModel.fromJson(data);
    result = result + modelClass.results;
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

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
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
                      // child: const Center(
                      //   child: CircularProgressIndicator(
                      //     strokeWidth: 4,
                      //   ),
                      // ),
                      );
            }
            return Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.check),
                    title: Text(result[index].message.toString()),
                    trailing: Text(
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
            );
          }),
    );
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
