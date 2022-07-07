import 'package:calendy/entity/event.dart';
import 'package:calendy/utils/event_data_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  final CalendarView view;
  const CalendarWidget({Key? key, required this.view}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarController _calendarController = CalendarController();

  List<Event> _getData() {
    final List<Event> events = [];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    events.add(Event('Dentiste', 'Je vais chez le dentiste maggle', startTime,
        endTime, false));
    events.add(Event('Same time', 'Je vais chez le dentiste maggle', startTime,
        endTime, false));
    return events;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _calendarController.view = widget.view;
    });
    return SfCalendar(
      dataSource: EventDataSource(_getData()),
      controller: _calendarController,
      view: widget.view,
    );
  }
}
