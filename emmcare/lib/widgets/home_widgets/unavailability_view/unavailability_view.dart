import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';

final today = DateUtils.dateOnly(DateTime.now());

class UnavailabilityView extends StatefulWidget {
  const UnavailabilityView({Key? key}) : super(key: key);
  @override
  State<UnavailabilityView> createState() => _UnavailabilityViewState();
}

class _UnavailabilityViewState extends State<UnavailabilityView> {
  List<DateTime?> _multiDatePickerValueWithDefaultValue = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        title: Text("Unavailability"),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: Card(
        child: _buildDefaultMultiDatePickerWithValue(),
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    }
    return valueText;
  }

  Widget _buildDefaultMultiDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: Color.fromARGB(255, 62, 89, 244),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        CalendarDatePicker2(
          config: config,
          initialValue: _multiDatePickerValueWithDefaultValue,
          onValueChanged: (values) =>
              setState(() => _multiDatePickerValueWithDefaultValue = values),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: [
            const Text('Selection(s):  '),
            const SizedBox(width: 10),
            Text(
              _getValueText(
                config.calendarType,
                _multiDatePickerValueWithDefaultValue,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
