import 'package:emmcare/Screens/home_screen.dart';
import 'package:emmcare/models/client_model.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    "5:45 AM - 8:45 AM",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.right,
                      "Community participation",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text("Client Name"),
                      Text("Client Address"),
                    ],
                  ),
                ],
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://scontent.fktm19-1.fna.fbcdn.net/v/t39.30808-6/275607503_275772231373960_2730988905792695328_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=JzD9i_hPVlMAX-RQYHZ&_nc_oc=AQn6rQslXxMEb5bMCicdRsefIcNZEX0qKd7k4Nh9EHDc8WUnLE-3rdqFhiqdR7do-hU&_nc_ht=scontent.fktm19-1.fna&oh=00_AfCmUjxKd0v4_sylpQ8SWRHzHwl1wT2bNPU2ICKkEaTQBg&oe=63C00D19"),
                      ),
                      trailing: Text("Status"),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
