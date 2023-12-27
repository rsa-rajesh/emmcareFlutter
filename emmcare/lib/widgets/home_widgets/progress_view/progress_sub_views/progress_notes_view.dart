import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:emmcare/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/progress_note_view_view_model.dart';

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
  //
  late bool imageAccepted;
  getImageFromGalley() async {
    imgXFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
      requestFullMetadata: true,
    );
    if (imgXFile!.path.endsWith("pdf")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("doc")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("docx")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("docs")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("jpg")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("jpeg")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("png")) {
      imageAccepted = true;
    } else {
      imageAccepted = false;
    }
    if (imageAccepted) {
      if (imgXFile != null) {
        setState(() {
          imgXFile;
        });
      }
    } else {
      Utils.toastMessage('This image extension is not allowed.');
      setState(() {
        imgXFile = null;
      });
    }
  }

  getImageFromCamera() async {
    imgXFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 200,
      maxWidth: 200,
      requestFullMetadata: true,
    );
    if (imgXFile!.path.endsWith("pdf")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("doc")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("docx")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("docs")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("jpg")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("jpeg")) {
      imageAccepted = true;
    } else if (imgXFile!.path.endsWith("png")) {
      imageAccepted = true;
    } else {
      imageAccepted = false;
    }
    if (imageAccepted) {
      if (imgXFile != null) {
        setState(() {
          imgXFile;
        });
      }
    } else {
      Utils.toastMessage('This image extension is not allowed.');
      setState(() {
        imgXFile = null;
      });
    }
  }

  // Note Controllers
  var _noteController = TextEditingController();
  // Dispose
  @override
  void dispose() {
    super.dispose();
    _noteController.dispose();
  }

  String _attachment = "";
  String _msg = "";
  String _category = "";
  ProgressNoteViewModel progressNoteViewModel = ProgressNoteViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.appBarColor,
        actions: [
          InkWell(
              onTap: () {
                if (_noteController.text.isEmpty) {
                  Utils.toastMessage("Progress notes Cannot be empty");
                } else {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      context = context;
                      return const Loading(
                        'Please wait \n  Adding notes',
                        false,
                      );
                    },
                  );
                  if (imgXFile == null) {
                    setState(() {
                      _msg = _noteController.text.toString();
                      _category = "note";
                      ProgressNoteViewModel().progressNoteWithoutImage(
                        context,
                        _category,
                        _msg,
                      );
                      imgXFile == null;
                      _noteController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  } else {
                    setState(() {
                      _msg = _noteController.text.toString();
                      _attachment = imgXFile!.path;
                      _category = "note";
                    });
                    ProgressNoteViewModel().progressNoteWithImage(
                      context,
                      _attachment,
                      _category,
                      _msg,
                    );
                    imgXFile == null;
                    _noteController.clear();
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
                    Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ))
        ],
        automaticallyImplyLeading: true,
        title: Text(
          "Add Notes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<ProgressNoteViewModel>(
          create: (BuildContext context) => progressNoteViewModel,
          child: Consumer<ProgressNoteViewModel>(
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
                      Divider(height: 5),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 0, 0),
                        child: Text(
                          "SHIFT REPORT .......*",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                        child: TextFormField(
                          controller: _noteController,
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
