import 'package:emmcare/widgets/home_widgets/events_view/shift_report_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../res/colors.dart';
import '../../../../../view/home_view.dart';
import '../../../view_model/events_view_view_moel.dart';

class EventsView extends StatefulWidget {
  @override
  _EventsViewState createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  EventsViewViewModel _eventsViewViewModel = EventsViewViewModel();
  final ScrollController _controller = ScrollController();
  bool _refresh = true;

  @override
  void initState() {
    _eventsViewViewModel.fetchEventsListApi(_refresh == false);
    super.initState();
    getClientAvatar();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _eventsViewViewModel.fetchEventsListApi(_refresh == false);
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<void> refresh() async {
    setState(() {
      _eventsViewViewModel.fetchEventsListApi(_refresh == true);
    });
  }

  String? cltAvatar;
  Future<void> getClientAvatar() async {
    final sharedpref = await SharedPreferences.getInstance();
    setState(() {
      cltAvatar = sharedpref.getString(HomeViewState.KEYCLIENTAVATAR)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: ChangeNotifierProvider<EventsViewViewModel>(
            create: (BuildContext context) => _eventsViewViewModel,
            child: Consumer<EventsViewViewModel>(
              builder: (context, value, child) {
                return ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _controller,
                  itemCount: value.events.length,
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
                                arguments: value.events[index],
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
                                            fit: BoxFit.cover, errorBuilder:
                                                (context, error, stackTrace) {
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
                                            value.events[index].message
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              value.events[index].category
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
                      ),
                    );
                  },
                );
              },
            )),
      ),
    );
  }
}
