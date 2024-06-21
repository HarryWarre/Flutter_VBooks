import 'package:flutter/material.dart';

import '../../data/model/categorymodel.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 100, // Adjust width as needed
        height: 50, // Adjust height as needed
        child: Center(
          child: Text(category.name!,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromRGBO(113, 114, 112, 1))),
        ),
      ),
    );
  }
}
