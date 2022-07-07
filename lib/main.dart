import 'package:calendy/home/home_view.dart';
import 'package:calendy/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = true;
  late Widget _view;

  Future<void> displayCorrectStartingView() async {
    const storage = FlutterSecureStorage();
    String? username = await storage.read(key: 'CALENDY_USERNAME');
    setState(() {
      _view =
          username == null ? const LoginView() : HomeView(username: username);
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    displayCorrectStartingView();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: Text('SPLASH SCREEN CALENDY'),
        ),
      );
    }
    return _view;
  }
}
