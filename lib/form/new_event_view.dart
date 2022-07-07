import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class NewEventView extends StatefulWidget {
  const NewEventView({Key? key}) : super(key: key);

  @override
  State<NewEventView> createState() => _NewEventViewState();
}

class _NewEventViewState extends State<NewEventView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();
  bool _allDay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: const SizedBox.shrink(),
          title: const Text('New Event'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: "Title", border: InputBorder.none),
                style: const TextStyle(fontSize: 30),
              ),
              const Divider(),
              Row(children: [
                Switch(
                    value: _allDay,
                    onChanged: (value) {
                      setState(() {
                        _allDay = value;
                      });
                    }),
                const Text("All day?")
              ]),
              AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: _allDay
                      ? const SizedBox(
                          key: Key('notDisplayed'),
                        )
                      : Column(key: Key('displayed'), children: [
                          GestureDetector(
                              onTap: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  currentTime: _start,
                                  onConfirm: (date) {
                                    setState(() {
                                      _start = date;
                                      if (_end.compareTo(_start) < 0) {
                                        _end = _start;
                                      }
                                    });
                                  },
                                );
                              },
                              child: SizedBox(
                                  height: 50,
                                  child: Row(children: [
                                    Expanded(
                                        child: Text(
                                            DateFormat('yyyy-MM-dd kk:mm')
                                                .format(_start))),
                                    const Icon(Icons.calendar_month_outlined)
                                  ]))),
                          GestureDetector(
                              onTap: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  currentTime: _end,
                                  onConfirm: (date) {
                                    setState(() {
                                      _end = date;
                                    });
                                  },
                                );
                              },
                              child: SizedBox(
                                  height: 50,
                                  child: Row(children: [
                                    Expanded(
                                        child: Text(
                                            DateFormat('yyyy-MM-dd kk:mm')
                                                .format(_end))),
                                    const Icon(Icons.calendar_month_outlined)
                                  ])))
                        ])),
              TextFormField(
                controller: _descriptionController,
                minLines: 2,
                maxLines: 99,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                    hintText: "Description", border: InputBorder.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
