import 'package:emmcare/res/colors.dart';
import 'package:emmcare/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../model/user_model.dart';
import '../../../res/components/round_button.dart';
import '../../../view_model/unavailability_create_view_view_model.dart';
import '../../../view_model/user_view_view_model.dart';

class UnavailabilityView extends StatefulWidget {
  const UnavailabilityView({Key? key}) : super(key: key);
  @override
  State<UnavailabilityView> createState() => _UnavailabilityViewState();
}

class _UnavailabilityViewState extends State<UnavailabilityView> {
  UnavailabilityViewViewModel unavailabilityViewViewModel =
      UnavailabilityViewViewModel();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //text editing controller for text field (Unavailability Description)
  TextEditingController _unavailabilityController = TextEditingController();
  String token = "";
  TimeOfDay _startTime = TimeOfDay(hour: 12, minute: 00);
  TimeOfDay _endTime = TimeOfDay(hour: 11, minute: 59);
  bool _allDay = true;
  List<DateTime> _selectedDate = [];
  int? _dateCount;
  bool isBottonShow = false;
  int? bsValue = 0;
  late PersistentBottomSheetController _controller;
// final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _selectStartTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (newTime != null) {
      setState(() {
        _startTime = newTime;
      });
    }
  }

  void _selectEndTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (newTime != null) {
      setState(() {
        _endTime = newTime;
      });
    }
  }

  @override
  void initState() {
    _startTime =
        TimeOfDay(hour: 12, minute: 00); //set the initial value of text field
    _endTime =
        TimeOfDay(hour: 11, minute: 59); //set the initial value of text field
    super.initState();
    Future<UserModel> getUserData() => UserViewViewModel().getUser();
    getUserData().then((value) async {
      token = value.access.toString();
    });

    unavailabilityViewViewModel.unavailabilityList();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is List<DateTime>) {
      _dateCount = args.value.length;
      _selectedDate = args.value;
    }
    if (!isBottonShow && _dateCount! > 0) {
      isBottonShow = true;
      bsValue = _dateCount;
      bsheet();
    } else {
      bsValue = _dateCount;
      // int value = 0;
    }
    _controller.setState!(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Unavailability",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: ChangeNotifierProvider<UnavailabilityViewViewModel>(
          create: (BuildContext context) => unavailabilityViewViewModel,
          child: Consumer<UnavailabilityViewViewModel>(
            builder: (context, value, child) {
              return unavailabilityViewViewModel.loading
                  ? Center(
                      child: Column(
                        children: [
                          Spacer(),
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 12,
                          ),
                          Text("Loading Unavailability Records"),
                          Spacer(),
                        ],
                      ),
                    )
                  : Container(
                      child: SfDateRangePicker(
                        minDate: DateTime.now(),
                        cellBuilder: (BuildContext context,
                            DateRangePickerCellDetails details) {
                          final bool isToday =
                              isSameDate(details.date, DateTime.now());
                          final bool selectedDate =
                              isSelectedDate(details.date);
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedDate
                                      ? Colors.green
                                      : isToday
                                          ? Colors.amber
                                          : null,
                                  borderRadius: BorderRadius.circular(12),
                                  border: isToday
                                      ? Border.all(
                                          color: Colors.black, width: 2)
                                      : selectedDate
                                          ? Border.all(
                                              color: Colors.green.shade900,
                                              width: 2)
                                          : null),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    details.date.day.toString(),
                                    style: TextStyle(
                                      fontSize: selectedDate ? 18 : 13,
                                      color: unavailabilityViewViewModel
                                              .isUnavailableDate(
                                                  details.date.toString())
                                          ? Colors.red
                                          : selectedDate
                                              ? Colors.white
                                              : details.date.isAfter(
                                                      DateTime.now().subtract(
                                                          Duration(days: 1)))
                                                  ? Colors.black
                                                  : Colors.black38,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        selectionColor: const Color.fromARGB(0, 255, 193, 7),
                        navigationDirection:
                            DateRangePickerNavigationDirection.vertical,
                        enableMultiView: true,
                        backgroundColor: Colors.white38,
                        navigationMode: DateRangePickerNavigationMode.scroll,
                        headerStyle: DateRangePickerHeaderStyle(
                          textAlign: TextAlign.left,
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue.shade600),
                        ),
                        monthViewSettings: DateRangePickerMonthViewSettings(
                            blackoutDates:
                                unavailabilityViewViewModel.getBlockoutDates(),
                            dayFormat: "E",
                            viewHeaderHeight: 30,
                            numberOfWeeksInView: 6,
                            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87),
                            )),
                        onSelectionChanged: _onSelectionChanged,
                        // onViewChanged: viewChanged,
                        selectionMode: DateRangePickerSelectionMode.multiple,
                        initialSelectedRange: PickerDateRange(
                            DateTime.now().subtract(const Duration(days: 4)),
                            DateTime.now().add(const Duration(days: 3))),
                      ),
                    );
            },
          )),
    );
  }

  bsheet() async {
    _controller = await scaffoldKey.currentState!.showBottomSheet<dynamic>(
      backgroundColor: AppColors.bodyBackgroudColor,
      (context) {
        return StatefulBuilder(
          //
          //
          builder: (context, StateSetter setState) {
            if (bsValue == 0) {
              Future.delayed(Duration.zero, () {
                isBottonShow = false;
                Navigator.pop(context);
              });
            }

            return Card(
              elevation: 50,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            color: Colors.redAccent,
                            onPressed: () {
                              Navigator.pop(context);
                              isBottonShow = false;
                            },
                            icon: Icon(
                              Icons.cancel_rounded,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Container(
                      width: double.maxFinite,
                      height: 45,
                      color: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("$_dateCount Days",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("All",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Switch(
                          value: _allDay,
                          thumbColor:
                              MaterialStatePropertyAll<Color>(Colors.white),
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              _allDay = value;
                            });
                          },
                          activeTrackColor: Colors.green,
                          inactiveTrackColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Unavailability description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextFormField(
                            controller: _unavailabilityController,
                            style: new TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: "Enter an unavailability description",
                            )),

                        Visibility(
                          visible: !_allDay,
                          child: InkWell(
                            onTap: () => _selectStartTime(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //
                                //
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  child: Text("Start Time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                //
                                //

                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 16),
                                  child: Container(
                                    child: Text(
                                      _startTime.format(context),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                //
                                //
                              ],
                            ),
                          ),
                        ),

                        Visibility(
                          visible: !_allDay,
                          child: InkWell(
                            onTap: () => _selectEndTime(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Text("End Time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                //
                                //
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 16),
                                  child: Container(
                                    child: Text(
                                      _endTime.format(context),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                //
                                //
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                            "Select all the days where you are unavailable to work. The star time and end time will be applied to each.",
                            style: TextStyle(
                                fontSize: 14, fontStyle: FontStyle.italic)),
                        // RoundButton
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                          child: Container(
                            width: double.infinity,
                            child: RoundButton(
                              title: "Save\t" + "($_dateCount periods)",
                              onPress: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    context = context;
                                    return const Loading(
                                      'Posting unavailibility report',
                                      false,
                                    );
                                  },
                                );

                                String startFormattedTime =
                                    _startTime.format(context);

                                String endFormattedTime =
                                    _endTime.format(context);

                                Map<String, dynamic> decodedToken =
                                    JwtDecoder.decode(token);
                                var userName = decodedToken["username"];
                                var profileId = decodedToken["profile_id"];

                                List<dynamic> datas = getJsonData(
                                    _selectedDate,
                                    startFormattedTime.toString(),
                                    endFormattedTime.toString(),
                                    userName.toString(),
                                    profileId);
                                UnavailabilityViewViewModel()
                                    .unavailabilityCreate(datas, context);
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List getJsonData(List<DateTime> selectedDate, String stime, String etime,
      String uname, int id) {
    List<dynamic> data = [];

    for (var date in selectedDate) {
      dynamic date1 = {
        "unavailable_date": date.toString().split(" ")[0],
        "all_day": _allDay,
        "start_time": stime,
        "end_time": etime,
        "unavailable_reason": _unavailabilityController.text.toString(),
        "added_by": uname,
        "staff": id
      };
      data.add(date1);
    }
    return data;
  }

  bool isSelectedDate(DateTime date) {
    if (_selectedDate.contains(date)) {
      return true;
    }
    return false;
  }

  bool isSameDate(DateTime date, DateTime dateTime) {
    if (date.year == dateTime.year &&
        date.month == dateTime.month &&
        date.day == dateTime.day) {
      return true;
    }

    return false;
  }

  // void viewChanged(
  //     DateRangePickerViewChangedArgs dateRangePickerViewChangedArgs) {
  //   print(dateRangePickerViewChangedArgs.visibleDateRange.startDate.toString());
  // }
}
