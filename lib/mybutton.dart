import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const Mybutton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .65,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(20),
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'quickie'),
          ),
        ),
      ),
    );
  }
}
