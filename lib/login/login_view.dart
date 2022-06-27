import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 150)),
        SliverToBoxAdapter(
          child: Column(children: [
            const Text("Login"),
            Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration:
                              const InputDecoration(hintText: "Username"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(hintText: "Password"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        Text(_error, style: TextStyle(color: Colors.red)),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _error = "";
                            });
                            if (_formKey.currentState!.validate()) {
                              final response = await http.post(
                                  Uri.parse(
                                      'http://192.168.0.87:3000/security/login'),
                                  body: {
                                    'username': _usernameController.text,
                                    'password': _passwordController.text
                                  });
                              Map<String, dynamic> body =
                                  jsonDecode(response.body);
                              int statusCode = body['statusCode'];
                              if (statusCode == 404) {
                                setState(() {
                                  _error =
                                      "Username is wrong, please double check";
                                });
                              }
                              if (statusCode == 401) {
                                setState(() {
                                  _error = "Wrong password";
                                });
                              }
                            }
                          },
                          child: const Text('Login'),
                        )
                      ],
                    )))
          ]),
        )
      ]),
    );
  }
}
