import 'dart:convert';

import 'package:emmcare/models/client_model.dart';
import 'package:emmcare/widgets/home_widgets/calender_timeline_widget.dart';
import 'package:emmcare/widgets/home_widgets/card_widget.dart';
import 'package:emmcare/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  //
  //
  late Future<List<ClientModel>> futureClient;
  void initState() {
    super.initState();
    futureClient = fetchClient();
    //
    //
  }

// List of products coming from api.
  List<ClientModel> clientList = [];
// Future fuction used to fetch data from the server.
// It is also used to refresh the home page.
  Future<List<ClientModel>> fetchClient() async {
    // Encoded data from the api.
    final response = await http.get(
      Uri.parse("https://6396d55077359127a023e18b.mockapi.io/emmcare_client"),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.grey,
          onPressed: () {},
          child: Icon(size: 45, Icons.add_sharp),
          backgroundColor: Colors.grey,
        ),
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
          ],
          backgroundColor: Colors.grey,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      clientList[index].name.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    // height of the card widget
                                    height: 230,
                                    //  Home Screen Card Widget. //
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: CardWidget(),
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
      ),
    );
  }
}
