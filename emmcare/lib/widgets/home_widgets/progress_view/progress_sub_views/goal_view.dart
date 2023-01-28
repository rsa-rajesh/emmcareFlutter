import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GoalView extends StatefulWidget {
  const GoalView({super.key});

  @override
  State<GoalView> createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
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
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text('Name of client'),
                            ],
                          ),
                        ),
                      );
                    },
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
                          "Name of client",
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
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text('No Strategies Available'),
                            ],
                          ),
                        ),
                      );
                    },
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
                            title: Text("Error"),
                            content: Text("Choose a strtegy to rate!"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"))
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
}