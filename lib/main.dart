import 'package:brokecheck/deposit.dart';
import 'package:brokecheck/homepage.dart';
// ignore: unused_import
import 'package:brokecheck/login.dart';
import 'package:brokecheck/withdraw.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:brokecheck/settings.dart';

// ignore: unused_import
import 'get_started.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      routes: {
        '/homepage': (context) => Homepage(),
        '/settings': (context) => Settings(),
        '/getstarted': (context) => GetStartedPage(),
        '/withdraw': (context) => Withdraw(),
        '/deposit': (context) => Deposit(),
      },
    );
  }
}
