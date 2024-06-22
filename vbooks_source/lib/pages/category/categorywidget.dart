import 'package:flutter/material.dart';
import 'package:vbooks_source/data/model/categorymodel.dart';

import '../../component/productcard.dart';
import '../../component/searchform.dart';
import '../../data/model/productmodel.dart';
import '../../data/provider/categoryprovider.dart';
import '../../data/provider/productprovider.dart' as productprovider;
import 'categorycard.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  int? selectedCategoryId = 1;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProductsByCategory(1);
  }

  Future<void> _loadProductsByCategory(int categoryId) async {
    final filteredProducts =
        await productprovider.ReadData().loadDatabyCat(categoryId);
    setState(() {
      products = filteredProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: ReadData().loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final categories = snapshot.data!;

          return Column(
            children: [
              const SearchWidget(), // Add SearchWidget at the top
              SafeArea(
                top: true, // Only set top safety to true
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories
                        .map((category) => CategoryCard(
                              category: category,
                              isSelected: category.id == selectedCategoryId,
                              onTap: () {
                                setState(() {
                                  selectedCategoryId = category.id;
                                  _loadProductsByCategory(category.id ?? 1);
                                });
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.all(8.0), // Add padding around the grid
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7, // Adjust the aspect ratio if needed
                    children: products
                        .map((product) => Padding(
                              padding: const EdgeInsets.all(
                                  8.0), // Add padding between grid items
                              child: ProductCard(product: product),
                            ))
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
