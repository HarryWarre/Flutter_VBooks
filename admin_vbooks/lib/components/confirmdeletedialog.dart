import 'package:flutter/material.dart';
import 'package:admin_vbooks/config/const.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String title; // Customize title for different delete scenarios
  final String content; // Customize content for specific items being deleted
  final VoidCallback onConfirm;

  const ConfirmDeleteDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(content),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            SizedBox(
              width: 100,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Xóa',
                  style: TextStyle(color: danger),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
