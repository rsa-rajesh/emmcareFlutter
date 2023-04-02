import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ProgressViewViewModel progressViewViewModel = ProgressViewViewModel();

  @override
  void initState() {
    progressViewViewModel.fetchProgressListApi();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      floatingActionButton: SpeedDial(
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
              Navigator.pushNamed(context, RoutesName.injury);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.event),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Event',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.event);
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
              Navigator.pushNamed(context, RoutesName.enquiry);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Incident',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.incident);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.warning_amber_rounded),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Warning',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.warning);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.error_outline),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Feedback',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.feedback);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.person),
            backgroundColor: AppColors.floatingActionButtonColor,
            foregroundColor: Colors.white,
            label: 'Progress Notes',
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.progress_notes);
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
                  return AlertDialog(
                    icon: Icon(Icons.error_rounded, size: 30),
                    title: Text(
                      value.progressList.message.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              refresh();
                            },
                            child: Text(
                              'Refresh',
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            child: Text('Abort'),
                          ),
                        ],
                      )
                    ],
                  );

                case Status.COMPLETED:
                  if (value.progressList.data!.progress!.length == 0) {
                    return Center(
                        child: Text(
                      "No Progress!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ));
                  } else {
                    return ListView.builder(
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
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.blue[200],
                                        child: ClipOval(
                                            child: Icon(
                                          Icons.star,
                                          color: Colors.white,
                                        )),
                                      ),
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
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                value.progressList.data!
                                                    .progress![index].summary
                                                    .toString(),
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
                        );
                      },
                    );
                  }

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
      progressViewViewModel.fetchProgressListApi();
    });
  }

  // String timeAgoCustom(DateTime d) {
  //   Duration diff = DateTime.now().difference(d);
  //   if (diff.inDays > 365) {
  //     return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  //   }
  //   if (diff.inDays > 30) {
  //     return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  //   }
  //   if (diff.inDays > 7) {
  //     return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  //   }
  //   if (diff.inDays > 0) {
  //     return "${DateFormat.E().add_jm().format(d)}";
  //   }
  //   if (diff.inHours > 0) {
  //     return "Today ${DateFormat('jm').format(d)}";
  //   }
  //   if (diff.inMinutes > 0) {
  //     return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  //   }
  //   return "just now";
  // }
}
