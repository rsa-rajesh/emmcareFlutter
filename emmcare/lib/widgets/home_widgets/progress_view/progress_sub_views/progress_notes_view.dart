import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressNotesView extends StatefulWidget {
  const ProgressNotesView({super.key});

  @override
  State<ProgressNotesView> createState() => _ProgressNotesViewState();
}

class _ProgressNotesViewState extends State<ProgressNotesView> {
  @override
  void initState() {
    super.initState();

    // Step:1
    //
    getClientName();
    getClientAvatar();
  }

  // Step:2
  //
  String? cltName;
  String? cltAvatar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        actions: [
          InkWell(
              onTap: () {},
              splashColor: Colors.lightBlueAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.save),
                    SizedBox(
                      width: 10,
                    ),
                    Center(
                      child: Text("Save"),
                    ),
                  ],
                ),
              ))
        ],
        automaticallyImplyLeading: true,
        title: Text(
          "Add Notes",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Card(
          child: Wrap(
            children: [
              InkWell(
                onTap: () {
                  showAdaptiveActionSheet(
                    context: context,
                    title: const Text(
                      'Select Image',
                      style: TextStyle(fontSize: 18),
                    ),
                    androidBorderRadius: 15,
                    actions: <BottomSheetAction>[
                      BottomSheetAction(
                          title: const Text(
                            'Take Photo',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: (context) {}),
                      BottomSheetAction(
                          title: const Text(
                            'Choose from Library',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: (context) {}),
                    ],
                    cancelAction: CancelAction(
                      title: const Text('Cancel'),
                    ),
                  );
                },
                splashColor: Colors.lightBlueAccent,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.buttonColor,
                          radius: 30,
                          child: ClipOval(
                            child: Image.network(
                                "http://pwnbot-agecare-backend.clouds.nepalicloud.com" +
                                    cltAvatar.toString(),
                                width: 150,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                color: Colors.white,
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "UPLOAD IMAGE",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.notifications, size: 30),
                    Text(
                      cltName!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Divider(height: 5),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text(
                  "SHIFT REPORT .......*",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: TextFormField(
                  maxLines: null,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: "your notes",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    hintMaxLines: 5,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getClientName() async {
    final sharedpref = await SharedPreferences.getInstance();

    setState(() {
      cltName = sharedpref.getString(HomeViewState.KEYCLIENTNAME)!;
    });
  }

  Future<void> getClientAvatar() async {
    final sharedpref = await SharedPreferences.getInstance();

    setState(() {
      cltAvatar = sharedpref.getString(HomeViewState.KEYCLIENTAVATAR)!;
    });
  }
}
