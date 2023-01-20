import 'dart:convert';
import 'dart:async';
import 'package:emmcare/model/client_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/widgets/home_widgets/calender_timeline_widget.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class JobBoardView extends StatefulWidget {
  JobBoardView({super.key});

  @override
  State<JobBoardView> createState() => JobBoardViewState();
}

class JobBoardViewState extends State<JobBoardView> {
  late Future<List<ClientModel>> futureClient;

  void initState() {
    super.initState();

    futureClient = fetchClient();

    //
    //
  }

  // List of Client coming from api.
  List<ClientModel> clientList = [];

  // Future fuction used to fetch data from the server.
// It is also used to refresh the home page.
  Future<List<ClientModel>> fetchClient() async {
    // Encoded data from the api.
    final response = await http.get(
      Uri.parse("https://63c0ed02376b9b2e646fc208.mockapi.io/clients"),
    );
    // Decoded data
    var data = jsonDecode(response.body);
    // clearing the list item.
    clientList.clear();
    if (response.statusCode == 200) {
      for (Map i in data) {
        setState(() {
          clientList.add(ClientModel.fromJson(i));
        });
      }
      return clientList;
    } else {
      throw Exception("Failed to load Product.");
    }
  }

  //
  // App bar current Month and year.
  String currentMonth = DateFormat.LLL().format(DateTime.now());
  String currentYear = DateFormat("yyyy").format(DateTime.now());
  //
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(currentMonth),
          SizedBox(width: 5),
          Text(currentYear),
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
        ],
        backgroundColor: AppColors.appBarColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Calendar timeline widget.
            CalendarTimelineWidget(),
            Flexible(
              child: FutureBuilder<List<ClientModel>>(
                future: fetchClient(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: fetchClient,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: clientList.length,
                        // Make listView scrollable
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    clientList[index].id.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  // height of the card widget
                                  height: 220,
                                  //  Home Screen Card Widget. //
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Card(
                                        elevation: 3,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    snapshot.data![index].time
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.right,
                                                      "Community participation",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data![index].name
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot.data![index]
                                                                .address!.street
                                                                .toString() +
                                                            snapshot
                                                                .data![index]
                                                                .address!
                                                                .zipcode
                                                                .toString(),
                                                        // clientList[index]
                                                        //     .address!
                                                        //     .suite
                                                        //     .toString(),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot.data![index]
                                                            .address!.city
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Expanded(child: Container()),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ListTile(
                                                      visualDensity: VisualDensity
                                                          .adaptivePlatformDensity,
                                                      leading: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(snapshot
                                                                .data![index]
                                                                .avatar
                                                                .toString()),
                                                      ),
                                                      trailing: Text(
                                                        snapshot
                                                            .data![index].status
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // Show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
