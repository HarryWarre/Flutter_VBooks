import 'package:flutter/material.dart';

class FeaturedListItem extends StatelessWidget {
  final int featuredID;

  const FeaturedListItem({super.key, required this.featuredID});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Featured ID: $featuredID'),
    );
  }
}
