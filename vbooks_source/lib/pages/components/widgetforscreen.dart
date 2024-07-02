

import 'package:flutter/material.dart';

class AccountShoppingRow extends StatelessWidget {
  final String label;
  final String value;

  AccountShoppingRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 2),
      child: Row(
        children: [
          Container(
            width: 200,
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              label,
              style: TextStyle(fontFamily: 'Italic'),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                value,
                style: TextStyle(fontFamily: 'Italic'),
                overflow: TextOverflow.ellipsis, // tránh overflow
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? style;
  final double? width;

  AccountInfoRow({required this.label,  required this.value, this.style, this.width = 120});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 2),
      child: Row(
        children: [
          Container(
            width: width,
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              label,
              style: style,
              overflow: TextOverflow.ellipsis, // tránh overflow
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                value,
                style: style,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountSelectWidget extends StatelessWidget {
  final String value;
  final IconData iconLeft;
  final IconData iconRight;
  final VoidCallback? onTap;

  AccountSelectWidget(
      {required this.value, required this.iconLeft, required this.iconRight, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconLeft,
        size: 26,
        color: Colors.teal,
      ),
      title: Text(value),
      trailing: Icon(
        iconRight,
        weight: 16,
        color: Colors.teal,
      ),
      onTap: onTap,
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double height;
  final Color? color;
  CustomDivider({this.height = 2, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.grey[300],
      width: double.infinity,
    );
  }
}