import 'package:emmcare/model/client_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../view_model/clock_in_view_model.dart';
import '../../../view_model/clock_out_view_model.dart';

class DetailsView extends StatefulWidget {
  // receive data from the FirstScreen as a parameter
  DetailsView({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  /* Step:- 1 */

  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final client_Detail = ModalRoute.of(context)!.settings.arguments as Clients;

    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      body: Column(
        children: [
          // Google Map Start.
          Container(
            height: height * .22,
            width: double.infinity,
            decoration: new BoxDecoration(
              color: Color.fromARGB(255, 227, 232, 233),
            ),
            child: getMap(client_Detail),
          ),
          // Google Map End.

          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Card(
                  child: Center(
                    child: Wrap(children: [
                      Center(
                        child: Text(
                          "STAFF",
                          style: TextStyle(
                            fontSize: 12,
                            foreground: Paint()
                              ..style = PaintingStyle.fill
                              ..strokeWidth = 1
                              ..color = Color.fromARGB(255, 15, 15, 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: CircleAvatar(
                              backgroundColor: AppColors.buttonColor,
                              backgroundImage:
                                  ExactAssetImage('assets/images/pwnbot.png'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "EMMC Support Services",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                )),
                VerticalDivider(
                  width: 1,
                  thickness: 2.0,
                  endIndent: 4.0,
                  indent: 4.0,
                ),
                Expanded(
                    child: InkWell(
                  splashColor: Colors.white70,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.client_profile);
                  },
                  child: Card(
                    child: Center(
                      child: Wrap(children: [
                        Center(
                          child: Text(
                            "CLIENT",
                            style: TextStyle(
                              fontSize: 12,
                              foreground: Paint()
                                ..style = PaintingStyle.fill
                                ..strokeWidth = 1
                                ..color = Color.fromARGB(255, 15, 15, 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: CircleAvatar(
                                backgroundColor: AppColors.buttonColor,
                                child: ClipOval(
                                  child: Image.network(
                                      "http://pwnbot-agecare-backend.clouds.nepalicloud.com" +
                                          client_Detail.clientImg.toString(),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover, errorBuilder:
                                          (context, error, stackTrace) {
                                    return Icon(
                                      // Icons.error,
                                      Icons.person,
                                      color: Colors.white,
                                    );
                                  }),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                client_Detail.client.toString(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                )),
              ],
            ),
          ),

          Card(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              color: Colors.black,
                              size: 22,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "DATE",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat("EEEE").format(
                                  DateTime.parse(
                                      client_Detail.shiftStartDate.toString()),
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                DateFormat("yMMMMd").format(
                                  DateTime.parse(
                                      client_Detail.shiftStartDate.toString()),
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.black,
                              size: 22,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "TIME",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.jm().format(DateFormat("hh:mm:ss").parse(
                                client_Detail.shiftStartTime.toString())),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text("-"),
                          Text(
                            DateFormat.jm().format(DateFormat("hh:mm:ss")
                                .parse(client_Detail.shiftEndTime.toString())),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              size: 22,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "LOCATION",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                        child: Text(
                          client_Detail.shiftFullAddress.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.instruction);
            },
            splashColor: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.list,
                        color: Colors.black,
                        size: 22,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "INSTRUCTION",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 13,
                  )
                ],
              ),
            ),
          ),

          checkClockInAndOut(client_Detail.clockIn.toString()),
        ],
      ),
    );
  }

  getMap(Clients client_detail) {
    if (client_detail.location != null) {
      LatLng showLocation =
          LatLng(client_detail.location!.lat!, client_detail.location!.lng!);
      markers.add(Marker(
        //add marker on google map
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: client_detail.shiftFullAddress.toString(),
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      return GoogleMap(
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: showLocation, //initial position
          zoom: 15, //initial zoom level
        ),
        markers: markers, //markers to show on map
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      );
    } else {
      return Center(
          child: Text(
        "No Map Available!",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Color.fromARGB(255, 15, 15, 15),
        ),
      ));
    }
  }

  Widget checkClockInAndOut(String checkclock) {
    if (checkclock == "null") {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Container(
          width: double.infinity,
          color: AppColors.buttonColor,
          child: TextButton.icon(
            onPressed: () {
              String datetime = DateFormat("HH:mm:ss").format(DateTime.now());
              ClockInViewModel().clockIn(context, datetime);
            },
            icon: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 30,
            ),
            label: Text(
              "CLOCK IN",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Container(
          width: double.infinity,
          color: AppColors.buttonColor,
          child: TextButton.icon(
              onPressed: () {
                String datetime = DateFormat("HH:mm:ss").format(DateTime.now());
                ClockOutViewModel().clockOut(context, datetime);
              },
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
              label: Text(
                "CLOCK OUT",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
        ),
      );
    }
  }
}
