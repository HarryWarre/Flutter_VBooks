import 'package:flutter/material.dart';
import 'package:vbooks_source/data/model/categorymodel.dart';

import '../../component/searchform.dart';
import '../../data/provider/categoryprovider.dart';
import 'categorycard.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: ReadData().loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final categories = snapshot.data!;

          return Column(
            // Use Column for vertical layout
            children: [
              const SearchWidget(), // Add SearchWidget at the top
              SafeArea(
                top: true, // Only set top safety to true
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories
                        .map((category) => CategoryCard(category: category))
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
