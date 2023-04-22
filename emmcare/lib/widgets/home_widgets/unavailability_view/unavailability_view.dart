import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../model/user_model.dart';
import 'package:intl/intl.dart';
import '../../../res/components/round_button.dart';
import '../../../view_model/unavailability_create_view_view_model.dart';
import '../../../view_model/user_view_view_model.dart';

class UnavailabilityView extends StatefulWidget {
  const UnavailabilityView({Key? key}) : super(key: key);
  @override
  State<UnavailabilityView> createState() => _UnavailabilityViewState();
}

class _UnavailabilityViewState extends State<UnavailabilityView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //text editing controller for text field (Unavailability Description)
  TextEditingController _unavailabilityController = TextEditingController();
  String token = "";
  TimeOfDay _startTime = TimeOfDay(hour: 12, minute: 00);
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

  TimeOfDay _endTime = TimeOfDay(hour: 11, minute: 59);
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

  bool _light = true;
  bool _allDay = true;
  int _numberOfDays = 0;
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
  }

  List<DateTime> _selectedDate = [];
  int _dateCount = 0;
  String _range = '';
  int _rangeCount = 0;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    bsheet();

    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    ///
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value;
        print(_selectedDate);
      } else if (args.value is List<DateTime>) {
        _selectedDate = args.value;
        _dateCount = args.value.length;
        print(args.value);
        print(_dateCount);
      } else {
        _rangeCount = args.value.length;
      }
    });
  }

  // Dispose
  @override
  void dispose() {
    super.dispose();
    _unavailabilityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    UnavailabilityViewViewModel unavailabilityViewViewModel =
        UnavailabilityViewViewModel();

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        title: Text("Unavailability"),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: ChangeNotifierProvider<UnavailabilityViewViewModel>(
          create: (BuildContext context) => unavailabilityViewViewModel,
          child: Consumer<UnavailabilityViewViewModel>(
            builder: (context, value, child) {
              return SfDateRangePicker(
                navigationDirection:
                    DateRangePickerNavigationDirection.vertical,
                enableMultiView: true,
                backgroundColor: Colors.white38,
                navigationMode: DateRangePickerNavigationMode.scroll,
                monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue.shade600),
                ),
                monthViewSettings: const DateRangePickerMonthViewSettings(
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
                selectionMode: DateRangePickerSelectionMode.multiple,
                initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3))),
              );
            },
          )),
    );
  }

  bsheet() {
    if (_dateCount == 0) {
    } else {
      scaffoldKey.currentState!.showBottomSheet<dynamic>(
        enableDrag: true,
        backgroundColor: AppColors.bodyBackgroudColor,
        (context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
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
                            value: _light,
                            activeColor: Colors.blue,
                            thumbColor:
                                MaterialStatePropertyAll<Color>(Colors.white),
                            onChanged: (bool value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                _light = value;
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
                          //
                          //
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
                            visible: _allDay,
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
                            visible: _allDay,
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
                          //
                          // RoundButton
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                            child: Container(
                              width: double.infinity,
                              child: RoundButton(
                                title: "Save\t" + "($_dateCount periods)",
                                onPress: () {
                                  DateTime startParsedTime = DateFormat.jm()
                                      .parse(_startTime
                                          .format(context)
                                          .toString());
                                  String startFormattedTime =
                                      DateFormat('HH:mm:ss')
                                          .format(startParsedTime);

                                  DateTime endParsedTime = DateFormat.jm()
                                      .parse(
                                          _endTime.format(context).toString());
                                  String endFormattedTime =
                                      DateFormat('HH:mm:ss')
                                          .format(endParsedTime);

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
}
