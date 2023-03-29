import 'dart:convert';
import 'package:emmcare/widgets/home_widgets/events_view/shift_report_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/events_model.dart';
import '../../../model/user_model.dart';
import '../../../res/app_url.dart';
import '../../../res/colors.dart';
import '../../../view/home_view.dart';
import '../../../view_model/user_view_view_model.dart';

class EventsView extends StatefulWidget {
  EventsView({Key? key}) : super(key: key);
  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  List<Result> result = [];
  ScrollController scrollController = ScrollController();
  bool loading = true;
  int offset = 1;

  bool _fetchingData = false;

  @override
  void initState() {
    super.initState();
    fetchData(offset);
    getClientAvatar();
    handleNext();
  }

  String? cltAvatar;
  Future<void> getClientAvatar() async {
    final sharedpref = await SharedPreferences.getInstance();
    setState(() {
      cltAvatar = sharedpref.getString(HomeViewState.KEYCLIENTAVATAR)!;
    });
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

    var response = await http.get(
      Uri.parse(
        AppUrl.getEventsList(page),
      ),
      headers: requestHeaders,
    );
    //
    print(response);
    print(AppUrl.getEventsList(page));
    //
    setState(() {
      var data = json.decode(response.body);
      EventsModel modelClass = EventsModel.fromJson(data);
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
        "No Events!",
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
                      // child: const Center(
                      //   child: CircularProgressIndicator(
                      //     strokeWidth: 4,
                      //   ),
                      // ),
                      );
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShiftReportView(),
                      settings: RouteSettings(
                        arguments: result[index],
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  AppColors.imageCircleAvatarBodyBackgroudColor,
                              radius: 26,
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
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    result[index].message.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(result[index].category.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.blue[200])),
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
}
