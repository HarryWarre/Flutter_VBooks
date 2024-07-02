import 'package:flutter/material.dart';
import 'package:vbooks_source/data/model/categorymodel.dart';
import 'package:vbooks_source/data/provider/categoryprovider.dart';

import '../components/productcard.dart';
import '../components/search/searchform.dart';
import '../../data/model/productmodel.dart';
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
              SearchWidget(), // Thêm SearchWidget ở đầu
              SafeArea(
                top: true, // Chỉ đặt top safety là true
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories
                        .map((category) => CategoryCard(
                              category: category,
                              isSelected: category.id == selectedCategoryId,
                              onTap: () {
                                setState(() {
                                  selectedCategoryId = category.id!;
                                  _loadProductsByCategory(category.id!);
                                });
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(
                      8.0), // Thêm padding xung quanh GridView
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio:
                        0.7, // Điều chỉnh tỷ lệ khung hình nếu cần thiết
                    children: products
                        .map((product) => Padding(
                              padding: const EdgeInsets.all(
                                  8.0), // Thêm padding giữa các mục trong grid
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