import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class CalendarTimelineWidget extends StatefulWidget {
  const CalendarTimelineWidget({super.key});

  @override
  State<CalendarTimelineWidget> createState() => _CalendarTimelineWidgetState();
}

class _CalendarTimelineWidgetState extends State<CalendarTimelineWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 0));
  }

  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
      showYears: false,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      onDateSelected: (date) => setState(() => _selectedDate = date),
      leftMargin: 20,
      monthColor: Colors.blueGrey,
      dayColor: Colors.teal[200],
      dayNameColor: const Color(0xFF333A47),
      activeDayColor: Colors.white,
      activeBackgroundDayColor: Colors.redAccent[100],
      dotsColor: const Color(0xFF333A47),
      selectableDayPredicate: (date) => date.day != 23,
      locale: 'en_ISO',
    );
  }
}
