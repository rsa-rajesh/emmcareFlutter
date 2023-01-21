import 'package:emmcare/data/response/status.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/utils/routes/routes_name.dart';

import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:emmcare/widgets/home_widgets/calender_timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JobBoardView extends StatefulWidget {
  JobBoardView({super.key});

  @override
  State<JobBoardView> createState() => JobBoardViewState();
}

class JobBoardViewState extends State<JobBoardView> {
  // App bar current Month and year.
  String currentMonth = DateFormat.LLL().format(DateTime.now());
  String currentYear = DateFormat("yyyy").format(DateTime.now());

  // JobBoardViewViewModel jobBoardViewViewModel = JobBoardViewViewModel();

  // @override
  // void initState() {
  //   jobBoardViewViewModel.fetchJobListApi();
  //   super.initState();
  // }

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

      body: Center(child: Text("Jobs")),
      // body: ChangeNotifierProvider<JobBoardViewViewModel>(
      //   create: (BuildContext context) => jobBoardViewViewModel,
      //   child: Consumer<JobBoardViewViewModel>(
      //     builder: (context, value, _) {
      //       switch (value.clientList.status) {
      //         case Status.LOADING:
      //           return Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         case Status.ERROR:
      //           return Center(
      //             child: Text(
      //               value.clientList.message.toString(),
      //             ),
      //           );

      //         case Status.COMPLETED:
      //           return Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 // Calendar timeline widget.
      //                 CalendarTimelineWidget(),

      //                 ListView.builder(
      //                   padding: const EdgeInsets.all(8.0),
      //                   itemCount: value.clientList.data!.clients!.length,
      //                   itemBuilder: (context, index) {
      //                     return Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         Expanded(
      //                           child: Container(
      //                             child: Text(
      //                               value.clientList.data!.clients![index].id
      //                                   .toString(),
      //                               textAlign: TextAlign.center,
      //                               style: TextStyle(
      //                                   color: Colors.black,
      //                                   fontSize: 12,
      //                                   fontWeight: FontWeight.bold),
      //                             ),
      //                           ),
      //                         ),
      //                         Expanded(
      //                           flex: 8,
      //                           child: Container(
      //                             // height of the card widget
      //                             height: 220,
      //                             //  Home Screen Card Widget. //
      //                             child: Padding(
      //                               padding: const EdgeInsets.all(7.0),
      //                               child: InkWell(
      //                                 onTap: () {
      //                                   Navigator.pushNamed(
      //                                       context, RoutesName.client_detail);
      //                                 },
      //                                 child: Card(
      //                                     elevation: 3,
      //                                     color: Colors.white,
      //                                     child: Padding(
      //                                       padding: const EdgeInsets.all(16.0),
      //                                       child: Column(
      //                                         mainAxisAlignment:
      //                                             MainAxisAlignment.spaceEvenly,
      //                                         children: [
      //                                           Row(
      //                                             crossAxisAlignment:
      //                                                 CrossAxisAlignment.start,
      //                                             children: [
      //                                               Expanded(
      //                                                   child: Text(
      //                                                 value.clientList.data!
      //                                                     .clients![index].time
      //                                                     .toString(),
      //                                                 style: TextStyle(
      //                                                     fontSize: 12,
      //                                                     fontWeight:
      //                                                         FontWeight.bold),
      //                                               )),
      //                                               SizedBox(
      //                                                 width: 8,
      //                                               ),
      //                                               Expanded(
      //                                                 child: Text(
      //                                                   overflow: TextOverflow
      //                                                       .ellipsis,
      //                                                   textAlign:
      //                                                       TextAlign.right,
      //                                                   "Community participation",
      //                                                   style: TextStyle(
      //                                                     fontSize: 14,
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                   ),
      //                                                 ),
      //                                               )
      //                                             ],
      //                                           ),
      //                                           Row(
      //                                             mainAxisAlignment:
      //                                                 MainAxisAlignment.start,
      //                                             children: [
      //                                               Column(
      //                                                 crossAxisAlignment:
      //                                                     CrossAxisAlignment
      //                                                         .start,
      //                                                 children: [
      //                                                   Text(
      //                                                     value
      //                                                         .clientList
      //                                                         .data!
      //                                                         .clients![index]
      //                                                         .name
      //                                                         .toString(),
      //                                                     style: TextStyle(
      //                                                       fontSize: 16,
      //                                                       fontWeight:
      //                                                           FontWeight.bold,
      //                                                     ),
      //                                                   ),
      //                                                   Text(
      //                                                     value
      //                                                         .clientList
      //                                                         .data!
      //                                                         .clients![index]
      //                                                         .address
      //                                                         .toString(),
      //                                                     style: TextStyle(
      //                                                       fontSize: 15,
      //                                                       fontWeight:
      //                                                           FontWeight.bold,
      //                                                     ),
      //                                                   ),
      //                                                   Text(
      //                                                     value
      //                                                         .clientList
      //                                                         .data!
      //                                                         .clients![index]
      //                                                         .address!
      //                                                         .city
      //                                                         .toString(),
      //                                                     style: TextStyle(
      //                                                       fontSize: 15,
      //                                                       fontWeight:
      //                                                           FontWeight.bold,
      //                                                     ),
      //                                                   )
      //                                                 ],
      //                                               ),
      //                                             ],
      //                                           ),
      //                                           Expanded(child: Container()),
      //                                           Row(
      //                                             children: [
      //                                               Expanded(
      //                                                 child: ListTile(
      //                                                   visualDensity: VisualDensity
      //                                                       .adaptivePlatformDensity,
      //                                                   leading: CircleAvatar(
      //                                                     backgroundImage:
      //                                                         NetworkImage(
      //                                                       value
      //                                                           .clientList
      //                                                           .data!
      //                                                           .clients![index]
      //                                                           .avatar
      //                                                           .toString(),
      //                                                     ),
      //                                                   ),
      //                                                   trailing: Text(
      //                                                     value
      //                                                         .clientList
      //                                                         .data!
      //                                                         .clients![index]
      //                                                         .status
      //                                                         .toString(),
      //                                                     style: TextStyle(
      //                                                       fontSize: 14,
      //                                                       fontWeight:
      //                                                           FontWeight.bold,
      //                                                     ),
      //                                                   ),
      //                                                 ),
      //                                               )
      //                                             ],
      //                                           )
      //                                         ],
      //                                       ),
      //                                     )),
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     );
      //                   },
      //                 ),
      //               ]);

      //         default:
      //           return Container(); // just to satisfy flutter analyzer
      //       }
      //     },
      //   ),
      // ),

      drawer: NavigationDrawer(),
    );
  }
}
