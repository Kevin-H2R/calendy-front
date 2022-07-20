import 'package:intl/intl.dart';

class Event {
  final String title;
  final String description;
  DateTime start;
  DateTime end;
  final bool allDay;

  Event(this.title, this.description, this.start, this.end, this.allDay);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        json['title'],
        json['description'],
        DateTime.parse(json['start']),
        DateTime.parse(json['end']),
        json['allDay'] == 'true');
  }

  String getFormattedStart() {
    return DateFormat('yyyy-MM-dd kk:mm').format(start);
  }

  String getFormattedEnd() {
    return DateFormat('yyyy-MM-dd kk:mm').format(end);
  }
}
