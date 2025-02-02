import 'package:brokecheck/deposit.dart';
import 'package:brokecheck/firebase_options.dart';
import 'package:brokecheck/homepage.dart';
import 'package:brokecheck/withdraw.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:brokecheck/settings.dart';
import 'get_started.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
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
