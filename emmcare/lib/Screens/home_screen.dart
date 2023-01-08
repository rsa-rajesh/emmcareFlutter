import 'dart:convert';

import 'package:emmcare/models/client_model.dart';
import 'package:emmcare/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // clientList.clear();
      for (Map i in data) {
        setState(() {
          clientList.add(ClientModel.fromJson(i));
        });
      }
      return clientList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
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
              CalendarTimeline(
                shrink: true,
                showYears: true,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                onDateSelected: (date) => setState(() => date),
                leftMargin: 20,
                monthColor: Colors.black54,
                dayColor: Colors.teal[200],
                dayNameColor: Colors.grey,
                activeDayColor: Colors.green,
                activeBackgroundDayColor: Colors.lightBlueAccent[100],
                dotsColor: const Color(0xFF333A47),
                selectableDayPredicate: (date) => date.day != 23,
                locale: "en",
              ),
              Flexible(
                fit: FlexFit.loose,
                child: FutureBuilder<List<ClientModel>>(
                  future: fetchClient(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return RefreshIndicator(
                        onRefresh: fetchClient,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          // Length of the list
                          itemCount: clientList.length,
                          // To make listView scrollable
                          // even if there is only a single item.
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
                                  flex: 5,
                                  child: Container(
                                    height: 230,
                                    child: Card(
                                      elevation: 2,
                                      color: Colors.white,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: const Text(
                                                '1625 Main Street',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              subtitle: const Text(
                                                  'My City, CA 99984'),
                                              leading: Icon(
                                                Icons.restaurant_menu,
                                                color: Colors.blue[500],
                                              ),
                                            ),
                                            ListTile(
                                              title: const Text(
                                                '(408) 555-1212',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              leading: Icon(
                                                Icons.contact_phone,
                                                color: Colors.blue[500],
                                              ),
                                            ),
                                            ListTile(
                                              title: const Text(
                                                  'costa@example.com'),
                                              leading: Icon(
                                                Icons.contact_mail,
                                                color: Colors.blue[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
