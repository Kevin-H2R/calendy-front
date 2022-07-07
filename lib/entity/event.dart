import 'package:intl/intl.dart';

class Event {
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final bool allDay;

  Event(this.title, this.description, this.start, this.end, this.allDay);

  String getFormattedStart() {
    return DateFormat('yyyy-MM-dd kk:mm').format(start);
  }

  String getFormattedEnd() {
    return DateFormat('yyyy-MM-dd kk:mm').format(end);
  }
}
