import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../model/client_profile_goal_model.dart';
import '../../../../../res/colors.dart';
import '../../../../../view/home_view.dart';
import '../../../../../view_model/client_goal_strategy_view_model.dart';
import '../../../../../view_model/client_profile_goal_view_view_model.dart';

class ClientProfileGoalView extends StatefulWidget {
  @override
  _ClientProfileGoalViewState createState() => _ClientProfileGoalViewState();
}

class _ClientProfileGoalViewState extends State<ClientProfileGoalView> {
  ClientProfileGoalViewViewModel _clientProfileGoalViewViewModel =
      ClientProfileGoalViewViewModel();
  final ScrollController _controller = ScrollController();
  bool _refresh = true;

  @override
  void initState() {
    _clientProfileGoalViewViewModel
        .fetchClientProfileGoalListApi(_refresh == false);
    super.initState();
    getClientId();
    _controller.addListener(_scrollListener);
  }

  int? cltId;
  Future<void> getClientId() async {
    final sharedpref = await SharedPreferences.getInstance();
    setState(() {
      cltId = sharedpref.getInt(HomeViewState.KEYCLIENTID)!;
    });
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _clientProfileGoalViewViewModel
          .fetchClientProfileGoalListApi(_refresh == false);
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<void> refresh() async {
    setState(() {
      _clientProfileGoalViewViewModel
          .fetchClientProfileGoalListApi(_refresh == true);
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
        onRefresh: refresh,
        child: ChangeNotifierProvider<ClientProfileGoalViewViewModel>(
            create: (BuildContext context) => _clientProfileGoalViewViewModel,
            child: Consumer<ClientProfileGoalViewViewModel>(
              builder: (context, value, child) {
                return value.goals.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _controller,
                        itemCount: value.goals.length,
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
                                    value.goals[index].name.toString(),
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
                                    value.goals[index].description.toString(),
                                    maxLines: _externalWidgetShowFlag &&
                                            _externalSelectedIndex == index
                                        ? value.goals[index].description!.length
                                        : 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                showInternalList(
                                    value.goals[index].goalStrategies),
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
                                                _externalSelectedIndex == index
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
              },
            )),
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
                                onPressed: () async {
                                  var star = _ratingValue;

                                  ClientGoalStrategyViewModel()
                                      .clientGoalStrategy(context, star);
                                  refresh();
                                  Navigator.of(context).pop();
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
