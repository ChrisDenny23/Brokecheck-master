import 'package:flutter/material.dart';

class Withdraw extends StatelessWidget {
  const Withdraw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Withdraw from cashbook",
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'poppy',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ));
  }
}
