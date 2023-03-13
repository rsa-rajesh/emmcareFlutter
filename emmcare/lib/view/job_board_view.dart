import 'package:emmcare/data/response/status.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:emmcare/view_model/job_board_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JobBoardView extends StatefulWidget {
  JobBoardView({super.key});
  @override
  State<JobBoardView> createState() => JobBoardViewState();
}

class JobBoardViewState extends State<JobBoardView> {
  // App bar current Month and year.
  String currentMonth = DateFormat.LLL().format(DateTime.now());
  String currentYear = DateFormat("yyyy").format(DateTime.now());

  JobBoardViewViewModel jobBoardViewViewModel = JobBoardViewViewModel();

  @override
  void initState() {
    jobBoardViewViewModel.fetchJobListApi();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Calendar controller and event list.
  final _calendarControllerCustom =
      AdvancedCalendarController.custom(DateTime.now());
  final List<DateTime> events = [DateTime.now(), DateTime(2022, 10, 10)];
  // Calendar controller and event list.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentMonth + "\t" + currentYear),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: ChangeNotifierProvider<JobBoardViewViewModel>(
          create: (BuildContext context) => jobBoardViewViewModel,
          child: Consumer<JobBoardViewViewModel>(
            builder: (context, value, _) {
              switch (value.JobList.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.ERROR:
                  return AlertDialog(
                    icon: Icon(Icons.error_rounded, size: 30),
                    title: Text(
                      value.JobList.message.toString(),
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
                  return Column(
                    children: [
                      // ...
                      Theme(
                        data: ThemeData.light().copyWith(
                          textTheme: ThemeData.light().textTheme.copyWith(
                                subtitle1: ThemeData.light()
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                                bodyText1: ThemeData.light()
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                bodyText2: ThemeData.light()
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                              ),
                          primaryColor: Colors.blueAccent,
                          highlightColor: Colors.yellow,
                          disabledColor: Colors.green,
                        ),
                        child: AdvancedCalendar(
                          controller: _calendarControllerCustom,
                          events: events,
                          weekLineHeight: 48.0,
                          startWeekDay: 0,
                          innerDot: true,
                          keepLineSize: true,
                          calendarTextStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.3125,
                            letterSpacing: 0,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: ListView.builder(
                            itemCount: value.JobList.data!.jobs!.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              value.JobList.data!.jobs![index]
                                                  .number
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              value.JobList.data!.jobs![index]
                                                  .day
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          value.JobList.data!.jobs![index].job
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );

                default:
                  return Container(); // just to satisfy flutter analyzer
              }
            },
          ),
        ),
      ),
      drawer: NavDrawer(),
    );
  }

  Future<void> refresh() async {
    setState(() {
      jobBoardViewViewModel.fetchJobListApi();
    });
  }
}
