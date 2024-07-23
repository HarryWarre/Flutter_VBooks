import 'package:flutter/material.dart';

import '../../data/model/categorymodel.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  // const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 50, // Adjust height as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.name!,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected
                      ? const Color.fromRGBO(31, 32, 36, 1)
                      : const Color.fromRGBO(113, 114, 112, 1),
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.only(
                        top: 5), // Adjust the space above the underline
                    height: 3, // Adjust the thickness of the underline
                    width: isSelected
                        ? 30
                        : 0, // Adjust the width of the underline
                    color: const Color.fromRGBO(
                        21, 139, 125, 1), // Green color for the underline
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
