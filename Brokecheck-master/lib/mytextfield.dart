import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  const Mytextfield({
    super.key,
    required this.label,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black54),
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontFamily: 'poppy',
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
        floatingLabelStyle: const TextStyle(
          color: Colors.green,
          fontFamily: 'poppy',
        ),
      ),
      obscureText: obscureText,
    );
  }
}
