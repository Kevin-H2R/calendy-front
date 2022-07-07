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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendy'),
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
                child: Text('Logout'))
          ],
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(child: SfCalendar()),
      ]),
    );
  }
}
