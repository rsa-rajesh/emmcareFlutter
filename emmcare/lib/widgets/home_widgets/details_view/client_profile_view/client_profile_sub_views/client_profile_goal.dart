import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../model/client_profile_goal_model.dart';
import '../../../../../model/user_model.dart';
import '../../../../../res/app_url.dart';
import '../../../../../res/colors.dart';
import '../../../../../view/home_view.dart';
import '../../../../../view_model/user_view_view_model.dart';

class ClientProfileGoalView extends StatefulWidget {
  ClientProfileGoalView({Key? key}) : super(key: key);

  @override
  State<ClientProfileGoalView> createState() => _ClientProfileGoalViewState();
}

class _ClientProfileGoalViewState extends State<ClientProfileGoalView> {
  List<Result> result = [];
  ScrollController scrollController = ScrollController();
  bool loading = true;
  int offset = 1;
  @override
  void initState() {
    super.initState();
    getClientId();
    fetchData(offset);
    handleNext();
  }

  int? cltId;
  Future<void> getClientId() async {
    final sharedpref = await SharedPreferences.getInstance();
    setState(() {
      cltId = sharedpref.getInt(HomeViewState.KEYCLIENTID)!;
    });
  }

  void fetchData(page) async {
    setState(() {
      loading = true;
    });
    var token = "";
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      setState(() {
        token = value.access.toString();
      });
    });
    await Future.delayed(Duration(microseconds: 1));
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse(
        AppUrl.getClientProfileGoalList(page),
      ),
      headers: requestHeaders,
    );
    //
    //
    print(response);
    print(
      AppUrl.getClientProfileGoalList(page),
    );
    //
    //
    var data = json.decode(response.body);
    ClientProfileGoalModel modelClass = ClientProfileGoalModel.fromJson(data);
    result = result + modelClass.results!;
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

  bool widgetShowFlag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
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
              color:
                  widgetShowFlag ? AppColors.bodyBackgroudColor : Colors.white,
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                    child: Text(
                      result[index].name.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                    child: Text(
                      result[index].description.toString(),
                      maxLines: widgetShowFlag
                          ? result[index].description!.length
                          : 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  showInternalList(result[index].goalStrategies!.length),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                            onPressed: () {
                              setState(() {
                                widgetShowFlag = !widgetShowFlag;
                              });
                            },
                            child: widgetShowFlag
                                ? Text(
                                    "Show Less",
                                    style: TextStyle(color: Colors.blue),
                                  )
                                : Text("Show More",
                                    style: TextStyle(color: Colors.blue)))
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget showInternalList(int internalList) {
    if (widgetShowFlag) {
      return ListView.builder(
        itemCount: internalList,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text(
                            'Rate Strategies',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            Container(
                              alignment: Alignment.center,
                              child: RatingBar.builder(
                                initialRating: result[index]
                                    .goalStrategies![index]
                                    .rating!
                                    .toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  print(result[index].goalStrategies!.length);
                                },
                              ),
                            )
                          ],
                        ));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          result[index]
                              .goalStrategies![index]
                              .description
                              .toString(),
                        ),
                      ),
                      Text(result[index]
                          .goalStrategies![index]
                          .rating
                          .toString()),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
