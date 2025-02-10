import "package:flutter/material.dart";
import 'package:brokecheck/abhihomedes.dart';
import 'package:brokecheck/mywidgets/accordion.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Abhihomedes(
      Items: ListView.separated(
        itemCount: 13, // Number of Accordions
        separatorBuilder: (context, index) => SizedBox(height: 12), // Spacing
        itemBuilder: (context, index) => Accordion(),
      ),
    );
  }
}
