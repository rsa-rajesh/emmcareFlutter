import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    getClientName();
  }

  String? cltName;

  // This is the file that will be used to store the image
  XFile? imgXFile;
  // This is the image picker
  final ImagePicker imagePicker = ImagePicker();

  getImageFromGalley() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXFile;
    });
  }

  getImageFromCamera() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgXFile;
    });
  }

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
                          onPressed: (context) {
                            getImageFromCamera();
                            Navigator.pop(context);
                          }),
                      BottomSheetAction(
                          title: const Text(
                            'Choose from Library',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: (context) {
                            getImageFromGalley();
                            Navigator.pop(context);
                          }),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            radius: MediaQuery.of(context).size.width * 0.10,
                            backgroundImage: imgXFile == null
                                ? null
                                : FileImage(File(imgXFile!.path)),
                            child: imgXFile == null
                                ? Icon(
                                    Icons.add_photo_alternate,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.width *
                                        0.10,
                                  )
                                : null,
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
              Divider(),
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
              Divider(height: 5),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 0, 0),
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
}
