import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalView extends StatefulWidget {
  const GoalView({super.key});

  @override
  State<GoalView> createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  @override
  void initState() {
    super.initState();

    // Step:1
    //
    getClientName();
  }

  // Step:2
  //
  String? cltName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: true,
        title: Text(
          "Rate Client",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Card(
          child: Wrap(
            children: [
              InkWell(
                onTap: () {
                  // showModalBottomSheet<void>(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return SizedBox(
                  //       height: 200,
                  //       child: Center(
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: <Widget>[
                  // Text(
                  //   cltName!,
                  //   style: TextStyle(
                  //       fontSize: 16, fontWeight: FontWeight.w900),
                  // ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                  showAdaptiveActionSheet(
                    context: context,
                    androidBorderRadius: 30,
                    actions: <BottomSheetAction>[
                      BottomSheetAction(
                          title: Text(
                            cltName!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                          onPressed: (context) {}),
                    ],
                    cancelAction: CancelAction(
                      title: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                    ),
                  );
                },
                splashColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Row(
                    children: [
                      Icon(Icons.notifications, size: 30),
                      Expanded(
                        child: Text(
                          cltName!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined, size: 30),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // showModalBottomSheet<void>(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return SizedBox(
                  //       height: 200,
                  //       child: Center(
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: const <Widget>[
                  //             Text(
                  //               'No Strategies Available',
                  //               style: TextStyle(
                  //                   fontSize: 16, fontWeight: FontWeight.w900),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                  showAdaptiveActionSheet(
                    context: context,
                    androidBorderRadius: 30,
                    actions: <BottomSheetAction>[
                      BottomSheetAction(
                          title: Text(
                            'No Strategies Available',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                          onPressed: (context) {}),
                    ],
                    cancelAction: CancelAction(
                      title: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                    ),
                  );
                },
                splashColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Row(
                    children: [
                      Icon(Icons.battery_full_outlined, size: 30),
                      Expanded(
                        child: Text(
                          "No Strategies Available",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined, size: 30),
                    ],
                  ),
                ),
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                child: ListTile(
                  trailing: Ink(
                    decoration: ShapeDecoration(
                      color: AppColors.buttonColor,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.save_outlined),
                      iconSize: 35,
                      color: Colors.white,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "Error",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            content: Text(
                              "Choose a strategy to rate!",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w900),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black),
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getClientName() async {
    final sharedpref = await SharedPreferences.getInstance();

    setState(() {
      cltName = sharedpref.getString(HomeViewState.KEYCLIENTNAME)!;
    });
  }
}
