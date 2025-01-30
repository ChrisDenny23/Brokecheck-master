import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Spidey boy",
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'poppy',
              fontWeight: FontWeight.bold,
              color: Colors.green),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("images/pfp.jpg"),
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
      ),
    );
  }
}
