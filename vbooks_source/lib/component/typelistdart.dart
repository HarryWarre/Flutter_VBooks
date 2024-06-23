import 'package:flutter/material.dart';

class TypeList extends StatelessWidget {
  final String data;

  const TypeList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TypeList'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text(data),
        ),
      ),
    );
  }
}
