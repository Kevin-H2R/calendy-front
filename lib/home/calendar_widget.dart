import 'package:calendy/entity/event.dart';
import 'package:calendy/utils/event_data_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  final CalendarView view;
  final Function(Event?) notifyEventTapped;
  final Function(DateTime?) notifyDateTimeSelected;
  const CalendarWidget(
      {Key? key,
      required this.view,
      required this.notifyEventTapped,
      required this.notifyDateTimeSelected})
      : super(key: key);

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
    events.add(Event(
        'Long description',
        """C'est un event avec un description assez longue. 
J'essaye d'ecrire n'importe quoi. Cependant j'ai la flemme de changer la langue du clavier
a chaque fois pour rajouter les accents. Ca rend le texte surement moins lisible mais en meme
temps je suis le seul a le lire donc bon. D'ailleur je ne le lit meme pas, je verifie
juste comment une longue description va deborder du Widget.
C'est un event avec un description assez longue. 
J'essaye d'ecrire n'importe quoi. Cependant j'ai la flemme de changer la langue du clavier
a chaque fois pour rajouter les accents. Ca rend le texte surement moins lisible mais en meme
temps je suis le seul a le lire donc bon. D'ailleur je ne le lit meme pas, je verifie
juste comment une longue description va deborder du Widget.""",
        startTime,
        startTime.add(const Duration(hours: 4)),
        false));
    return events;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _calendarController.view = widget.view;
    });
    return Column(children: [
      Expanded(
          child: SfCalendar(
        firstDayOfWeek: 1,
        onTap: (calendarTapDetails) {
          widget.notifyDateTimeSelected(calendarTapDetails.date);
          if (calendarTapDetails.targetElement == CalendarElement.appointment) {
            final Event appointment = calendarTapDetails.appointments![0];
            widget.notifyEventTapped(appointment);
            return;
          }
          widget.notifyEventTapped(null);
        },
        dataSource: EventDataSource(_getData()),
        controller: _calendarController,
        view: widget.view,
      )),
      const SizedBox(height: 50)
    ]);
  }
}
