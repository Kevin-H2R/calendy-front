import 'package:calendy/entity/event.dart';
import 'package:calendy/home/calendar_widget.dart';
import 'package:calendy/home/event_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeView extends StatefulWidget {
  final String username;
  const HomeView({Key? key, required this.username}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CalendarView _view = CalendarView.day;
  Event? _featuredEvent;
  final PanelController _panelController = PanelController();

  void _changeView(CalendarView view) {
    if (_view == view) {
      return;
    }
    setState(() {
      _view = view;
    });
  }

  void _eventTapped(Event? event) {
    event == null ? _panelController.close() : _panelController.open();
    setState(() {
      _featuredEvent = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        body: Stack(children: [
          CalendarWidget(
            view: _view,
            notifyEventTapped: _eventTapped,
          ),
          SlidingUpPanel(
            controller: _panelController,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            minHeight: _featuredEvent == null ? 0 : 50,
            maxHeight: 300,
            panel: _featuredEvent == null
                ? const SizedBox.shrink()
                : EventInformation(event: _featuredEvent!),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: _featuredEvent == null
                    ? const Color(0xFF2196F3)
                    : const Color(0x992196F3),
                child: const Icon(Icons.add),
              ))
        ]));
  }
}
