import 'package:emmcare/data/response/status.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../view_model/client_profile_documents_view_view_model.dart';
import '../../../../file_viewer/client_profile_documents_viewer.dart';

class ClientProfileDocumentsView extends StatefulWidget {
  ClientProfileDocumentsView({super.key});

  @override
  State<ClientProfileDocumentsView> createState() =>
      _ClientProfileDocumentsViewState();
}

class _ClientProfileDocumentsViewState
    extends State<ClientProfileDocumentsView> {
  ClientProfileDocumentsViewViewModel clientProfileDocumentsViewViewModel =
      ClientProfileDocumentsViewViewModel();

  @override
  void initState() {
    clientProfileDocumentsViewViewModel.fetchClientProfileDocumentsListApi();
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
        child: ChangeNotifierProvider<ClientProfileDocumentsViewViewModel>(
          create: (BuildContext context) => clientProfileDocumentsViewViewModel,
          child: Consumer<ClientProfileDocumentsViewViewModel>(
            builder: (context, value, _) {
              switch (value.clientProfiledocumentsList.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case Status.ERROR:
                  return AlertDialog(
                    icon: Icon(Icons.error_rounded, size: 30),
                    title: Text(
                      value.clientProfiledocumentsList.message.toString(),
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
                    itemCount: value.clientProfiledocumentsList.data!
                        .clientProfileDocuments!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: IconButton(
                            iconSize: 30,
                            splashColor: Colors.lightBlueAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ClientProfileDocumentsViewer(),
                                  // Pass the arguments as part of the RouteSettings. The
                                  // DetailScreen reads the arguments from these settings.
                                  settings: RouteSettings(
                                    arguments: value.clientProfiledocumentsList
                                        .data!.clientProfileDocuments![index],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.picture_as_pdf),
                          ),
                          title: Text(
                            value.clientProfiledocumentsList.data!
                                .clientProfileDocuments![index].documentName
                                .toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
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
      drawer: NavDrawer(),
    );
  }

  Future<void> refresh() async {
    setState(() {
      clientProfileDocumentsViewViewModel.fetchClientProfileDocumentsListApi();
    });
  }
}
