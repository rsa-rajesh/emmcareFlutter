import 'dart:async';
import 'package:emmcare/model/client_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/routes/routes_name.dart';
import 'package:emmcare/widgets/home_widgets/details_view/instructions_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../view_model/clock_in_view_model.dart';
import '../../../view_model/clock_out_view_model.dart';
import 'package:geolocator/geolocator.dart';

class DetailsView extends StatefulWidget {
  // receive data from the FirstScreen as a parameter
  DetailsView({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  late double long;
  late double lat;

  /* Step:- 1 */
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  String _instruction = "";

  var distanceInMeters;

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    long = position.longitude;
    lat = position.latitude;
    setState(() {
      //refresh U
    });
  }

  Future calc(Clients client_Detail) async {
    distanceInMeters = await Geolocator.distanceBetween(
      client_Detail.location!.lat!,
      client_Detail.location!.lng!,
      lat,
      long,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final client_Detail = ModalRoute.of(context)!.settings.arguments as Clients;
    calc(client_Detail);
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
                          "MEMBER",
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
                              backgroundColor:
                                  AppColors.imageCircleAvatarBodyBackgroudColor,
                              child: ClipOval(
                                child: Image.network(
                                    "https://api.emmcare.pwnbot.io" +
                                        client_Detail.staffImg.toString(),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    // Icons.error,
                                    Icons.person,
                                    color: Colors.white,
                                  );
                                }),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              client_Detail.staff.toString(),
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
                          Navigator.pushNamed(
                              context, RoutesName.client_profile);
                        },
                        child: Card(
                          child: Center(
                              child: Wrap(children: [
                            Center(
                              child: Text(
                                "PARTICIPANT",
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors
                                          .imageCircleAvatarBodyBackgroudColor,
                                      child: ClipOval(
                                        child: Image.network(
                                            "https://api.emmcare.pwnbot.io" +
                                                client_Detail.clientImg
                                                    .toString(),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover, errorBuilder:
                                                (context, error, stackTrace) {
                                          return Icon(
                                              // Icons.error,
                                              Icons.person,
                                              color: Colors.white);
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
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)))
                                ])
                          ])),
                        ))),
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
                          Icon(Icons.date_range_outlined,
                              color: Colors.black, size: 22),
                          SizedBox(width: 10),
                          Text("DATE",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w900)),
                        ],
                      ))),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  DateFormat("EEEE").format(
                                    DateTime.parse(client_Detail.shiftStartDate
                                        .toString()),
                                  ),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900)),
                              Text(
                                  DateFormat("yMMMMd").format(
                                    DateTime.parse(client_Detail.shiftStartDate
                                        .toString()),
                                  ),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900))
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
                            Icon(Icons.access_time,
                                color: Colors.black, size: 22),
                            SizedBox(width: 10),
                            Text("TIME",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              DateFormat.jm().format(DateFormat("hh:mm:ss")
                                  .parse(
                                      client_Detail.shiftStartTime.toString())),
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w900)),
                          Text("-"),
                          Text(
                            DateFormat.jm().format(DateFormat("hh:mm:ss")
                                .parse(client_Detail.shiftEndTime.toString())),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w900),
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
                            Icon(Icons.location_on_outlined,
                                color: Colors.black, size: 22),
                            SizedBox(width: 10),
                            Text("LOCATION",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      )),
                      Expanded(
                        child: Text(client_Detail.shiftFullAddress.toString(),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            onTap: () {
              _instruction = client_Detail.instruction.toString();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      InstructionView(instructionReceived: _instruction)));
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

          checkClockInAndOut(client_Detail.clockIn.toString(), client_Detail),
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
            zoom: 15 //initial zoom level
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

  Widget checkClockInAndOut(String checkclock, Clients client_detail) {
    if (checkclock == "null") {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Container(
          width: double.infinity,
          color: AppColors.buttonColor,
          child: TextButton.icon(
            onPressed: () {
              // Utils.toastMessage("$distanceInMeters");
              if (distanceInMeters == null || distanceInMeters < 500.00) {
                ClockInViewModel().clockIn(context);
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(
                              "Cannot clock In before approaching to the client location."),
                          icon: Icon(
                            Icons.error,
                            size: 45,
                          ),
                          iconColor: Colors.redAccent[400],
                        ));
                Future.delayed(
                    Duration(seconds: 2), () => Navigator.of(context).pop());
              }
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
                // Utils.toastMessage("$distanceInMeters");
                if (distanceInMeters == null || distanceInMeters < 500.00) {
                  ClockOutViewModel().clockOut(context);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Text(
                                "Cannot clock out before approaching to the client location."),
                            icon: Icon(
                              Icons.error,
                              size: 45,
                            ),
                            iconColor: Colors.redAccent[400],
                          ));
                  Future.delayed(
                      Duration(seconds: 2), () => Navigator.of(context).pop());
                }
              },
              icon: Icon(Icons.play_arrow, color: Colors.white, size: 30),
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
