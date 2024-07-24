import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vbooks_source/data/model/categorymodel.dart';
import 'package:vbooks_source/pages/components/productcard.dart';
import 'package:vbooks_source/viewmodel/categoryviewmodel.dart';
import 'package:vbooks_source/viewmodel/productviewmodel.dart';
import '../components/search/searchform.dart';
import 'categorycard.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialCategories();
    });
  }

  Future<void> _fetchInitialCategories() async {
    final categoryViewModel =
        Provider.of<CategoryViewModel>(context, listen: false);
    await categoryViewModel.fetchCategories();

    if (categoryViewModel.categories.isNotEmpty) {
      setState(() {
        selectedCategoryId = categoryViewModel.categories.first.id;
      });
      await _fetchProductsForCategory(selectedCategoryId!);
    }
  }

  Future<void> _fetchProductsForCategory(String categoryId) async {
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    await productViewModel.fetchProductsByCategory(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Search form
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: SearchWidget(),
            ),
            // Category List or other widgets
            Consumer<CategoryViewModel>(
              builder: (context, categoryViewModel, child) {
                if (categoryViewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (categoryViewModel.categories.isEmpty) {
                  return const Center(child: Text('Không có danh mục nào'));
                } else {
                  final categories = categoryViewModel.categories;

                  return Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: categories.map((category) {
                            return CategoryCard(
                              category: category,
                              isSelected: category.id == selectedCategoryId,
                              onTap: () {
                                if (category.id != selectedCategoryId) {
                                  setState(() {
                                    selectedCategoryId = category.id;
                                  });
                                  _fetchProductsForCategory(category.id!);
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 400, // Điều chỉnh chiều cao của GridView
                        child: Consumer<ProductViewModel>(
                          builder: (context, productViewModel, child) {
                            if (productViewModel.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (productViewModel.products.isEmpty) {
                              return const Center(
                                  child: Text('Không có sản phẩm nào'));
                            } else {
                              return GridView.builder(
                                padding: const EdgeInsets.all(8.0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Hai cột
                                  crossAxisSpacing:
                                      8.0, // Khoảng cách giữa các cột
                                  mainAxisSpacing:
                                      8.0, // Khoảng cách giữa các hàng
                                  childAspectRatio:
                                      0.7, // Tỷ lệ khung hình của thẻ sản phẩm, điều chỉnh để làm ngắn thẻ
                                ),
                                itemCount: productViewModel.products.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      productViewModel.products[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(
                                        4.0), // Điều chỉnh padding cho các phần tử
                                    child: ProductCard(product: product),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
