import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/response/status.dart';
import '../../../../../main.dart';
import '../../../../../model/client_profile_goal_model.dart';
import '../../../../../res/colors.dart';
import '../../../../../view/home_view.dart';
import '../../../../../view_model/client_goal_strategy_view_model.dart';
import '../../../../../view_model/client_profile_goal_view_view_model.dart';

class ClientProfileGoalView extends StatefulWidget {
  @override
  ClientProfileGoalViewState createState() => ClientProfileGoalViewState();
}

class ClientProfileGoalViewState extends State<ClientProfileGoalView> {
  int page = 1;
  ClientProfileGoalViewViewModel clientProfileGoalViewViewModel =
      ClientProfileGoalViewViewModel();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    clientProfileGoalViewViewModel.fetchClientProfileGoalListApi(page);
    super.initState();
    getClientId();
  }

  int? cltId;
  Future<void> getClientId() async {
    final sharedpref = await SharedPreferences.getInstance();
    setState(() {
      cltId = sharedpref.getInt(HomeViewState.KEYCLIENTID)!;
    });
  }

  Future<void> refresh() async {
    setState(() {
      clientProfileGoalViewViewModel.fetchClientProfileGoalListApi(page);
    });
  }

  // For External list
  bool _externalWidgetShowFlag = false;
  int? _externalSelectedIndex;

  // For inner list
  bool internalWidgetShowFlag = false;
  int? _internalSelectedIndex;

  // The rating value
  double? _ratingValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return refresh();
        },
        child: ChangeNotifierProvider<ClientProfileGoalViewViewModel>(
          create: (BuildContext context) => clientProfileGoalViewViewModel,
          child: Consumer<ClientProfileGoalViewViewModel>(
            builder: (context, value, _) {
              switch (value.clientProfileGoalList.status) {
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
                  return value.clientProfileGoalList.data!.results!.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Goals!",
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
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount:
                              value.clientProfileGoalList.data!.results!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: _externalWidgetShowFlag
                                  ? AppColors.bodyBackgroudColor
                                  : Colors.white,
                              margin: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 6, 12, 0),
                                    child: Text(
                                      value.clientProfileGoalList.data!
                                          .results![index].name
                                          .toString(),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 6, 12, 0),
                                    child: Text(
                                      value.clientProfileGoalList.data!
                                          .results![index].description
                                          .toString(),
                                      maxLines: _externalWidgetShowFlag &&
                                              _externalSelectedIndex == index
                                          ? value
                                              .clientProfileGoalList
                                              .data!
                                              .results![index]
                                              .description!
                                              .length
                                          : 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  showInternalList(value.clientProfileGoalList
                                      .data!.results![index].goalStrategies),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _externalSelectedIndex = index;
                                              _externalWidgetShowFlag =
                                                  !_externalWidgetShowFlag;
                                            });
                                          },
                                          child: _externalWidgetShowFlag &&
                                                  _externalSelectedIndex ==
                                                      index
                                              ? Text(
                                                  "Show Less",
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                )
                                              : Text(
                                                  "Show More",
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );

                default:
                  return Container(); // just to satisfy flutter analyzer
              }
            },
          ),
        ),
      ),
    );
  }

  Widget showInternalList(List<GoalStrategy>? goalStrategies) {
    if (_externalWidgetShowFlag) {
      return ListView.builder(
        itemCount: goalStrategies!.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('internalId', goalStrategies[index].id!);
                showDialog(
                    barrierDismissible: true,
                    context: navigatorKey.currentContext!,
                    builder: (_) => AlertDialog(
                          title: Text(
                            'Rate Strategies',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            Container(
                              alignment: Alignment.center,
                              child: RatingBar.builder(
                                initialRating:
                                    goalStrategies[index].rating!.toDouble(),
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
                                onRatingUpdate: (value) {
                                  setState(() {
                                    _ratingValue = value;
                                  });
                                },
                                updateOnDrag: true,
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
                                  var star = _ratingValue;
                                  ClientGoalStrategyViewModel()
                                      .clientGoalStrategy(
                                          navigatorKey.currentContext!, star);
                                  Future.delayed(
                                      Duration(seconds: 1), () => refresh());
                                  Navigator.of(navigatorKey.currentContext!)
                                      .pop();
                                },
                              ),
                            )
                          ],
                        ));
              },
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              goalStrategies[index].description.toString(),
                              maxLines: internalWidgetShowFlag &&
                                      _internalSelectedIndex == index
                                  ? goalStrategies[index].description!.length
                                  : 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(goalStrategies[index].rating.toString()),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _internalSelectedIndex = index;
                                  internalWidgetShowFlag =
                                      !internalWidgetShowFlag;
                                });
                              },
                              child: internalWidgetShowFlag &&
                                      _internalSelectedIndex == index
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
