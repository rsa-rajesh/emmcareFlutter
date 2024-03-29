import 'package:emmcare/res/colors.dart';
import 'package:emmcare/res/components/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  String _appVersion = "";
  @override
  void initState() {
    _getAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        title: Text(
          "About",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
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
                      "assets/images/emmc_care_icon.png",
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Text(
                    "Version\t" + _appVersion,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
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
            height: 70,
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
                    onTap: () async {
                      final url = Uri.parse(
                        'https://www.emmc.com.au/',
                      );

                      if (await canLaunchUrl(url)) {
                        launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        // ignore: avoid_print
                        print("Can't launch $url");
                      }
                    },
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
                    onTap: () async {
                      final url = Uri.parse(
                        'https://emmcare.pwnbot.io/help',
                      );

                      if (await canLaunchUrl(url)) {
                        launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        // ignore: avoid_print
                        print("Can't launch $url");
                      }
                    },
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
                    onTap: () async {
                      final url = Uri.parse(
                        'https://emmcare.pwnbot.io/termsandcondition',
                      );

                      if (await canLaunchUrl(url)) {
                        launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        // ignore: avoid_print
                        print("Can't launch $url");
                      }
                    },
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
                    onTap: () async {
                      final url = Uri.parse(
                        'https://emmcare.pwnbot.io/privacypolicy',
                      );

                      if (await canLaunchUrl(url)) {
                        launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        // ignore: avoid_print
                        print("Can't launch $url");
                      }
                    },
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Copyright @ Emmc Care Pvt.Ltd.",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          // Third Row ended.
          //
          //
        ],
      ),
    );
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    setState(() {});
  }
}
