import 'package:calendy/entity/event.dart';
import 'package:flutter/cupertino.dart';

class EventInformation extends StatelessWidget {
  final Event event;
  const EventInformation({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            event.title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Text(event.getFormattedStart()),
          Text(event.getFormattedEnd()),
          const SizedBox(height: 20),
          Expanded(
              child: SingleChildScrollView(child: Text(event.description))),
          const SizedBox(height: 10),
        ]));
  }
}
