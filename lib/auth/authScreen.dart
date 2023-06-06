import 'package:flutter/material.dart';
import 'package:todoapp/auth/authForm.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: const AuthForm(),
    );
  }
}
