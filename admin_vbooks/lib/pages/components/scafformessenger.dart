import 'package:flutter/material.dart';

class MessengerSnackBar extends StatelessWidget {
  final String message;
  final ScaffoldMessengerState messenger;

  const MessengerSnackBar({
    Key? key,
    required this.message,
    required this.messenger,
  }) : super(key: key);

  void show() {
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Component này không cần build gì cả
  }
}
