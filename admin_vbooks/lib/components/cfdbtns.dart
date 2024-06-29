import 'package:flutter/material.dart';

class CFDButtons extends StatelessWidget {
  final VoidCallback onPressedAdd;
  final VoidCallback onPressFile;
  final VoidCallback onPressDelete;

  const CFDButtons({
    super.key,
    required this.onPressedAdd,
    required this.onPressFile,
    required this.onPressDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Adjust as needed
      // decoration: const BoxDecoration(
      //   color: Colors.grey[200], // Adjust as needed
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle Add action
              onPressedAdd();
            },
            child: const Text('Thêm'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Handle Upload action
              onPressFile();
            },
            icon: const Icon(Icons.upload), // Replace with appropriate icon
            label: const Text('Tải lên'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle Delete action
              onPressDelete();
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
