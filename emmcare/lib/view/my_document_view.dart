// import 'dart:io';
import 'package:emmcare/data/response/status.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:emmcare/widgets/file_viewer/my_document_viewer.dart';
import 'package:emmcare/view_model/my_document_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyDocumentView extends StatefulWidget {
  MyDocumentView({super.key});

  @override
  State<MyDocumentView> createState() => _MyDocumentViewState();
}

class _MyDocumentViewState extends State<MyDocumentView> {
  MyDocumentViewViewModel myDocumentViewViewModel = MyDocumentViewViewModel();

  @override
  void initState() {
    myDocumentViewViewModel.fetchDocumentsListApi();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text("My Document"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return refresh();
        },
        child: ChangeNotifierProvider<MyDocumentViewViewModel>(
          create: (BuildContext context) => myDocumentViewViewModel,
          child: Consumer<MyDocumentViewViewModel>(
            builder: (context, value, _) {
              switch (value.mydocumentList.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case Status.ERROR:
                  return AlertDialog(
                    icon: Icon(Icons.error_rounded, size: 30),
                    title: Text(
                      value.mydocumentList.message.toString(),
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
                    itemCount: value.mydocumentList.data!.mydocuments!.length,
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
                                  builder: (context) => MyDocumentViewer(),
                                  // Pass the arguments as part of the RouteSettings. The
                                  // DetailScreen reads the arguments from these settings.
                                  settings: RouteSettings(
                                    arguments: value.mydocumentList.data!
                                        .mydocuments![index],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.picture_as_pdf),
                          ),
                          title: Text(
                            value.mydocumentList.data!.mydocuments![index]
                                .documentName
                                .toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          trailing: Text(
                            value.mydocumentList.data!.mydocuments![index]
                                .expiryDate
                                .toString(),
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
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
      myDocumentViewViewModel.fetchDocumentsListApi();
    });
  }
}
