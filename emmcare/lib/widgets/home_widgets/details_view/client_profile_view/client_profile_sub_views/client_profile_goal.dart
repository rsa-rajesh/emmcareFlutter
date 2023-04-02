import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../../data/response/status.dart';
import '../../../../../res/colors.dart';
import '../../../../../view_model/client_profile_goal_view_view_model.dart';

class ClientProfileGoalView extends StatefulWidget {
  const ClientProfileGoalView({super.key});

  @override
  State<ClientProfileGoalView> createState() => _ClientProfileGoalViewState();
}

class _ClientProfileGoalViewState extends State<ClientProfileGoalView> {
  ClientProfileGoalViewViewModel clientProfileGoalViewViewModel =
      ClientProfileGoalViewViewModel();

  @override
  void initState() {
    clientProfileGoalViewViewModel.fetchClientProfileGoalListApi();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
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
                  return AlertDialog(
                    icon: Icon(Icons.error_rounded, size: 30),
                    title: Text(
                      value.clientProfileGoalList.message.toString(),
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
                  return ListView.builder(
                    itemCount:
                        value.clientProfileGoalList.data!.results!.length,
                    itemBuilder: (context, index) {
                      return Text("Goals");
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

  Future<void> refresh() async {
    setState(() {
      clientProfileGoalViewViewModel.fetchClientProfileGoalListApi();
    });
  }
}
