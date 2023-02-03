import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../../data/response/status.dart';
import '../../../../../view_model/client_profile_detail_view_view_model.dart';
import '../../../../file_viewer/client_profile_documents_viewer.dart';

class ClientProfileDetailView extends StatefulWidget {
  const ClientProfileDetailView({super.key});

  @override
  State<ClientProfileDetailView> createState() =>
      _ClientProfileDetailViewState();
}

class _ClientProfileDetailViewState extends State<ClientProfileDetailView> {
  ClientProfileDetailViewViewModel clientProfileDetailViewViewModel =
      ClientProfileDetailViewViewModel();

  @override
  void initState() {
    clientProfileDetailViewViewModel.fetchClientProfileDetailListApi();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return refresh();
        },
        child: ChangeNotifierProvider<ClientProfileDetailViewViewModel>(
          create: (BuildContext context) => clientProfileDetailViewViewModel,
          child: Consumer<ClientProfileDetailViewViewModel>(
            builder: (context, value, _) {
              switch (value.clientProfileDetailList.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case Status.ERROR:
                  return AlertDialog(
                    icon: Icon(Icons.error_rounded, size: 30),
                    title: Text(
                      value.clientProfileDetailList.message.toString(),
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
                    itemCount: value.clientProfileDetailList.data!
                        .clientProfileDetail!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            value.clientProfileDetailList.data!
                                .clientProfileDetail![index].generalInformation
                                .toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            value.clientProfileDetailList.data!
                                .clientProfileDetail![index].detail
                                .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
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

  Future<void> refresh() async {
    setState(() {
      clientProfileDetailViewViewModel.fetchClientProfileDetailListApi();
    });
  }
}
