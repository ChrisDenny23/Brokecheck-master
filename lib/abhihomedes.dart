import 'package:flutter/material.dart';
import 'package:brokecheck/mywidgets/accordion.dart';

class Abhihomedes extends StatefulWidget {
  final Widget Items;

  Abhihomedes({super.key, required this.Items});

  @override
  State<Abhihomedes> createState() => _AbhihomedesState();
}

class _AbhihomedesState extends State<Abhihomedes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_rounded,
              color: Colors.white,
            ),
            label: "home",
          ),
          NavigationDestination(
              icon: Icon(
                Icons.subscriptions,
                color: Colors.white,
              ),
              label: "home"),
          NavigationDestination(
              icon: Icon(
                Icons.credit_card,
                color: Colors.white,
              ),
              label: "home"),
        ],
        backgroundColor: Color.fromRGBO(255, 255, 255, 0),
      ),
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        child: widget.Items,
      ),
    );
  }
}
