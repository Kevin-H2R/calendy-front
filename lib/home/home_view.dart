import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("HOME PAGE"),
        TextButton(
            onPressed: () {
              const storage = FlutterSecureStorage();
              storage.delete(key: 'CALENDY_ID');
              storage.delete(key: 'CALENDY_USERNAME');
              Phoenix.rebirth(context);
            },
            child: Text('Logout'))
      ]),
    );
  }
}
