import 'package:flutter/material.dart';

//display error message
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            icon: Icon(Icons.warning_amber_outlined),
            title: Text(message),
          ));
}
