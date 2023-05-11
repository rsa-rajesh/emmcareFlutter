import 'package:emmcare/widgets/home_widgets/events_view/shift_report_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../res/colors.dart';
import '../../../../../view/home_view.dart';
import '../../../data/response/status.dart';
import '../../../res/components/navigation_drawer.dart';
import '../../../view_model/events_view_view_moel.dart';

class EventsView extends StatefulWidget {
  @override
  _EventsViewState createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  int page = 1;
  EventsViewViewModel eventsViewViewModel = EventsViewViewModel();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    eventsViewViewModel.fetchEventsListApi(page);
    super.initState();
    getClientAvatar();
  }

  String? cltAvatar;
  Future<void> getClientAvatar() async {
    final sharedpref = await SharedPreferences.getInstance();
    setState(() {
      cltAvatar = sharedpref.getString(HomeViewState.KEYCLIENTAVATAR)!;
    });
  }

  Future<void> refresh() async {
    setState(() {
      eventsViewViewModel.fetchEventsListApi(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return refresh();
        },
        child: ChangeNotifierProvider<EventsViewViewModel>(
          create: (BuildContext context) => eventsViewViewModel,
          child: Consumer<EventsViewViewModel>(
            builder: (context, value, _) {
              switch (value.eventsList.status) {
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
                  return value.eventsList.data!.results!.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Events!",
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
                          itemCount: value.eventsList.data!.results!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShiftReportView(),
                                      settings: RouteSettings(
                                        arguments: value
                                            .eventsList.data!.results![index],
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
                                              backgroundColor: AppColors
                                                  .imageCircleAvatarBodyBackgroudColor,
                                              radius: 26,
                                              child: ClipOval(
                                                child: Image.network(
                                                    "http://pwnbot-agecare-backend.clouds.nepalicloud.com" +
                                                        cltAvatar!,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    value.eventsList.data!
                                                        .results![index].message
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
                                                          .eventsList
                                                          .data!
                                                          .results![index]
                                                          .category
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Colors
                                                              .blue[200])),
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
                        );

                default:
                  return Container();
              }
            },
          ),
        ),
      ),
      drawer: NavDrawer(),
    );
  }
}
