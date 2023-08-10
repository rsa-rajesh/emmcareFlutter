import 'package:emmcare/model/events_model.dart';
import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../view/home_view.dart';
import 'package:intl/intl.dart';

class ShiftReportView extends StatefulWidget {
  const ShiftReportView({super.key});
  @override
  State<ShiftReportView> createState() => _ShiftReportViewState();
}

class _ShiftReportViewState extends State<ShiftReportView> {
  @override
  void initState() {
    super.initState();
    getClientAvatar();
  }

  String? cltAvatar;
  Future<void> getClientAvatar() async {
    final sharedpref = await SharedPreferences.getInstance();
    setState(() {
      cltAvatar = sharedpref.getString(HomeViewState.KEYCLIENTAVATAR)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as Result;
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        title: Text(event.category.toString()),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 28,
                      child: ClipOval(
                        child: Image.network(
                            "https://api.emmcare.pwnbot.io" + cltAvatar!,
                            width: 55,
                            height: 55,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            color: Colors.white,
                          );
                        }),
                      ),
                    ),
                    title: Text(
                      "${event.staff.toString()} added a Note for ${event.client.toString()} @ ${DateFormat("yMMMMd").format(
                        DateTime.parse(event.createdAt.toString()),
                      )}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: showImage(
                      event.attachment.toString(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: Text(
                      event.category.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: Text(
                      event.message.toString(),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showImage(String? imageCheck) {
    if (imageCheck == null.toString()) {
      return Container();
    } else {
      var fileExtention = splitFileExtension(imageCheck.toString());
      print(fileExtention);
      var firstType = "jpg";
      var secondType = "png";
      var thirdType = "jpeg";
      if (fileExtention == firstType) {
        return Image.network(
            // "http://pwnbot-agecare-backend.clouds.nepalicloud.com" +
            imageCheck.toString());
      } else if (fileExtention == secondType) {
        return Image.network(
            // "http://pwnbot-agecare-backend.clouds.nepalicloud.com" +
            imageCheck.toString());
      } else if (fileExtention == thirdType) {
        return Image.network(
            // "http://pwnbot-agecare-backend.clouds.nepalicloud.com" +
            imageCheck.toString());
      } else {
        return Container();
      }
    }
  }

  String splitFileExtension(String fileName) {
    String unSplittedFileName = fileName;
    //split string
    var splitteFileName = unSplittedFileName.split('.');
    return splitteFileName[4];
  }
}
