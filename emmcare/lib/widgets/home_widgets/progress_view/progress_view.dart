import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../view_model/progress_view_view_model.dart';

class ProgressView extends StatefulWidget {
  ProgressView({super.key});
  @override
  State<ProgressView> createState() => ProgressViewState();
}

class ProgressViewState extends State<ProgressView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  ProgressViewViewModel progressViewViewModel = ProgressViewViewModel();

  @override
  void initState() {
    progressViewViewModel.fetchProgressListApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      floatingActionButton: SpeedDial(
        iconTheme: IconThemeData(color: Colors.white),
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
            child: Icon(Icons.personal_injury_outlined),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Injury',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.injury).then((_) {
                // This block runs when you have returned back to the 1st Page from 2nd.
                setState(() {
                  // Call setState to refresh the page.
                });
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.event),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Event',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.event).then((_) {
                // This block runs when you have returned back to the 1st Page from 2nd.
                setState(() {
                  // Call setState to refresh the page.
                });
              });
            },
          ),
          SpeedDialChild(
            //speed dial child
            child: Icon(Icons.search),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Enquiry',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.enquiry).then((_) {
                // This block runs when you have returned back to the 1st Page from 2nd.
                setState(() {
                  // Call setState to refresh the page.
                });
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Incident',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.incident).then((_) {
                // This block runs when you have returned back to the 1st Page from 2nd.
                setState(() {
                  // Call setState to refresh the page.
                });
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.warning_amber_rounded),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Warning',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.warning).then((_) {
                // This block runs when you have returned back to the 1st Page from 2nd.
                setState(() {
                  // Call setState to refresh the page.
                });
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.error_outline),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Feedback',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.feedback).then((_) {
                // This block runs when you have returned back to the 1st Page from 2nd.
                setState(() {
                  // Call setState to refresh the page.
                });
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.person),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Progress Notes',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.progress_notes).then((_) {
                // This block runs when you have returned back to the 1st Page from 2nd.
                setState(() {
                  // Call setState to refresh the page.
                });
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: ChangeNotifierProvider<ProgressViewViewModel>(
          create: (BuildContext context) => progressViewViewModel,
          child: Consumer<ProgressViewViewModel>(
            builder: (context, value, _) {
              switch (value.progressList.status) {
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
                  return value.progressList.data!.progress!.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Progress!",
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
                          itemCount: value.progressList.data!.progress!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Avatar(value.progressList.data!
                                              .progress![index].category!),
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
                                                  value.progressList.data!
                                                      .progress![index].msg
                                                      .toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    value
                                                        .progressList
                                                        .data!
                                                        .progress![index]
                                                        .summary
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Colors.blue[200])),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
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
      progressViewViewModel.fetchProgressListApi(context);
    });
  }

  Avatar(String _category) {
    if (_category == "note") {
      return CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.imageCircleAvatarBodyBackgroudColor,
        child: ClipOval(
            child: Icon(
          Icons.star,
          color: Colors.white,
        )),
      );
    } else if (_category == "feedback") {
      return CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.imageCircleAvatarBodyBackgroudColor,
        child: ClipOval(
            child: Icon(
          Icons.error_outline,
          color: Colors.white,
        )),
      );
    } else if (_category == "warning") {
      return CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.imageCircleAvatarBodyBackgroudColor,
        child: ClipOval(
            child: Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
        )),
      );
    } else if (_category == "incident") {
      return CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.imageCircleAvatarBodyBackgroudColor,
        child: ClipOval(
            child: Icon(
          Icons.brush,
          color: Colors.white,
        )),
      );
    } else if (_category == "enquiry") {
      return CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.imageCircleAvatarBodyBackgroudColor,
        child: ClipOval(
            child: Icon(
          Icons.search,
          color: Colors.white,
        )),
      );
    } else if (_category == "event") {
      return CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.imageCircleAvatarBodyBackgroudColor,
        child: ClipOval(
            child: Icon(
          Icons.event,
          color: Colors.white,
        )),
      );
    } else {
      return CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.imageCircleAvatarBodyBackgroudColor,
        child: ClipOval(
            child: Icon(
          Icons.personal_injury_outlined,
          color: Colors.white,
        )),
      );
    }
  }
}
