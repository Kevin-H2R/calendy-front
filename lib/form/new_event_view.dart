import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class NewEventView extends StatefulWidget {
  final DateTime start;
  const NewEventView({Key? key, required this.start}) : super(key: key);

  @override
  State<NewEventView> createState() => _NewEventViewState();
}

class _NewEventViewState extends State<NewEventView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late DateTime _start;
  late DateTime _end;
  bool _allDay = false;
  bool _ready = false;

  void createEvent() async {
    const storage = FlutterSecureStorage();
    String? id = await storage.read(key: 'CALENDY_ID');
    DateFormat formatter = DateFormat('yyyy-MM-dd kk:mm:ss');
    await http.post(Uri.parse("http://192.168.0.87:3000/events"), body: {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'start': formatter.format(_start),
      'end': formatter.format(_end),
      'allDay': _allDay.toString(),
      'userId': id
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _start = widget.start;
      _end = widget.start.add(const Duration(hours: 1));
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('New Event'),
          actions: [
            IconButton(
                onPressed: () {
                  if (_titleController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: const Text("Please fill the tile"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Got it"))
                              ],
                            ));
                    return;
                  }
                  createEvent();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check))
          ]),
      body: _ready
          ? Padding(
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
                        duration: const Duration(milliseconds: 200),
                        child: _allDay
                            ? const SizedBox(
                                key: Key('notDisplayed'),
                              )
                            : Column(key: const Key('displayed'), children: [
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
                                          const Icon(
                                              Icons.calendar_month_outlined)
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
                                          const Icon(
                                              Icons.calendar_month_outlined)
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
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
