import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/sub_event_view_view_model.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
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
    imgXFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
      requestFullMetadata: true,
    );

    setState(() {
      imgXFile;
    });
  }

  getImageFromCamera() async {
    imgXFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 200,
      maxWidth: 200,
      requestFullMetadata: true,
    );
    setState(
      () {
        imgXFile;
      },
    );
  }

  var _subEventController = TextEditingController();

  // Dispose
  @override
  void dispose() {
    super.dispose();
    _subEventController.dispose();
  }

  String _attachment = "";
  String _msg = "";
  String _category = "";

  SubEventViewModel subEventViewModel = SubEventViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        actions: [
          InkWell(
              onTap: () {
                if (_subEventController.text.isEmpty) {
                  Utils.toastMessage("Note Cannot be empty");
                } else {
                  if (imgXFile == null) {
                    setState(() {
                      _msg = _subEventController.text.toString();
                      _category = "event";
                    });
                    SubEventViewModel().subEventWithoutImage(
                      context,
                      _category,
                      _msg,
                    );
                    imgXFile = null;
                    _subEventController.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  } else {
                    setState(() {
                      _msg = _subEventController.text.toString();
                      _attachment = imgXFile!.path;
                      _category = "event";
                    });
                    SubEventViewModel().subEventWithImage(
                      context,
                      _attachment,
                      _category,
                      _msg,
                    );
                    imgXFile = null;
                    _subEventController.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                }
              },
              splashColor: Colors.lightBlueAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.save),
                    SizedBox(
                      width: 10,
                    ),
                    Center(child: Text("Save")),
                  ],
                ),
              ))
        ],
        automaticallyImplyLeading: true,
        title: Text(
          "Add Event",
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<SubEventViewModel>(
          create: (BuildContext context) => subEventViewModel,
          child: Consumer<SubEventViewModel>(
            builder: (context, value, child) {
              return SingleChildScrollView(
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
                                    radius: MediaQuery.of(context).size.width *
                                        0.10,
                                    backgroundImage: imgXFile == null
                                        ? null
                                        : FileImage(File(imgXFile!.path)),
                                    child: imgXFile == null
                                        ? Icon(
                                            Icons.add_photo_alternate,
                                            color: Colors.white,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                            Expanded(
                              child: Text(
                                cltName!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 6),
                        child: TextFormField(
                          controller: _subEventController,
                          maxLines: null,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: "your notes",
                            hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38),
                            hintMaxLines: 5,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 0.0,
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  Future<void> getClientName() async {
    final sharedpref = await SharedPreferences.getInstance();

    setState(() {
      cltName = sharedpref.getString(HomeViewState.KEYCLIENTNAME)!;
    });
  }
}
