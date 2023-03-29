import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../res/components/round_button.dart';

class UnavailabilityView extends StatefulWidget {
  const UnavailabilityView({Key? key}) : super(key: key);
  @override
  State<UnavailabilityView> createState() => _UnavailabilityViewState();
}

class _UnavailabilityViewState extends State<UnavailabilityView> {
  //text editing controller for text field (Unavailability Description)
  TextEditingController _unavailabilityController = TextEditingController();

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

  bool _light = false;
  int _numberOfDays = 0;

  @override
  void initState() {
    _startTime =
        TimeOfDay(hour: 12, minute: 00); //set the initial value of text field
    _endTime =
        TimeOfDay(hour: 11, minute: 59); //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        title: Text("Unavailability"),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: Column(
        children: [
          Container(
            height: height * .30,
            width: double.infinity,
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.multiple,
              backgroundColor: Colors.white,
              navigationDirection:
                  DateRangePickerNavigationDirection.horizontal,
            ),
          ),
          Expanded(
              child: Card(
            child: Container(
              height: height * .22,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Container(
                      width: double.maxFinite,
                      height: 45,
                      color: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("$_numberOfDays Days",
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
                            });
                          },
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
                        InkWell(
                          onTap: () => _selectStartTime(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              //
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Text("Start Time",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              //
                              //
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
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
                        InkWell(
                          onTap: () => _selectEndTime(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text("End Time",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              //
                              //
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
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
                        SizedBox(height: 5),
                        Text(
                            "Select all the days where you are unavailable to work. The star time and end time will be applied to each.",
                            style: TextStyle(
                                fontSize: 14, fontStyle: FontStyle.italic)),
                        //
                        // RoundButton
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                          child: Container(
                            width: double.infinity,
                            child: RoundButton(
                              title: "Save\t" + "($_numberOfDays periods)",
                              onPress: () {
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
            ),
          ))
        ],
      ),
    );
  }
}
