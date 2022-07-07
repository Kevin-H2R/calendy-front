import 'package:calendy/home/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeView extends StatefulWidget {
  final String username;
  const HomeView({Key? key, required this.username}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CalendarView _view = CalendarView.day;

  void _changeView(CalendarView view) {
    if (_view == view) {
      return;
    }
    setState(() {
      _view = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendy'),
        actions: [
          IconButton(
              onPressed: () {
                _changeView(CalendarView.month);
              },
              icon: const Icon(Icons.calendar_view_month)),
          IconButton(
              onPressed: () {
                _changeView(CalendarView.week);
              },
              icon: const Icon(Icons.calendar_view_week)),
          IconButton(
              onPressed: () {
                _changeView(CalendarView.day);
              },
              icon: const Icon(Icons.calendar_view_day)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text(widget.username)),
            TextButton(
                onPressed: () {
                  const storage = FlutterSecureStorage();
                  storage.delete(key: 'CALENDY_ID');
                  storage.delete(key: 'CALENDY_USERNAME');
                  Phoenix.rebirth(context);
                },
                child: const Text('Logout'))
          ],
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(child: CalendarWidget(view: _view)),
      ]),
    );
  }
}
