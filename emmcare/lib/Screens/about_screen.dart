import 'package:emmcare/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text(
            "About",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              //
              //
              //  First Row Started.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Image.asset(
                          "assets/images/app_logo_white.png",
                          height: 150,
                          width: 150,
                        ),
                      ),
                      Text(
                        "Version 1.0.0",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
              //  First Row ended.
              //
              //
              //
              SizedBox(
                height: 80,
              ),
              //
              //
              // Second Row started.
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        splashColor: Colors.blue,
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Official Website",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            Icon(Icons.arrow_forward_outlined, size: 22),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        splashColor: Colors.blue,
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Help",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            Icon(Icons.arrow_forward, size: 22),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        splashColor: Colors.blue,
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            Icon(Icons.arrow_forward, size: 22),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        splashColor: Colors.blue,
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            Icon(Icons.arrow_forward, size: 22),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Second Row ended.
              //
              //
              // Spacer started.
              Spacer(),
              // Spacer ended.
              //
              //
              // Third Row started.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Copyright @ EmmCare Ptv.Ltd.",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              // Third Row ended.
              //
              //
            ],
          ),
        ),
      ),
    );
  }
}
