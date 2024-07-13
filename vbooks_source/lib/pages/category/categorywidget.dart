import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vbooks_source/data/model/categorymodel.dart';
import 'package:vbooks_source/data/model/productmodel.dart';
import 'package:vbooks_source/viewmodel/categoryviewmodel.dart';
import 'package:vbooks_source/viewmodel/productviewmodel.dart';
import '../components/productcard.dart';
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
    // Fetch categories when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialCategories();
    });
  }

  Future<void> _fetchInitialCategories() async {
    final categoryViewModel =
        Provider.of<CategoryViewModel>(context, listen: false);
    await categoryViewModel.fetchCategories();

    if (categoryViewModel.categories.isNotEmpty) {
      // Set the default selected category
      setState(() {
        selectedCategoryId = categoryViewModel.categories.first.id;
      });

      // // Fetch products for the default selected category
      // if (selectedCategoryId != null) {
      //   await Provider.of<ProductViewModel>(context, listen: false)
      //       .fetchProductsByCategory(selectedCategoryId!);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, categoryViewModel, child) {
        if (categoryViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (categoryViewModel.categories.isEmpty) {
          return const Center(child: Text('No categories found'));
        } else {
          final categories = categoryViewModel.categories;

          return Column(
            children: [
              SearchWidget(), // Thêm SearchWidget ở đầu
              SafeArea(
                top: true, // Chỉ đặt top safety là true
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((category) {
                      return CategoryCard(
                        category: category,
                        isSelected: category.id == selectedCategoryId,
                        onTap: () async {
                          if (category.id != selectedCategoryId) {
                            setState(() {
                              selectedCategoryId = category.id;
                            });

                            // // Fetch products for the selected category
                            // if (selectedCategoryId != null) {
                            //   await Provider.of<ProductViewModel>(context,
                            //           listen: false)
                            //       .fetchProductsByCategory(selectedCategoryId!);
                            // }
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              Consumer<ProductViewModel>(
                builder: (context, productViewModel, child) {
                  if (productViewModel.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (productViewModel.products.isEmpty) {
                    return const Center(child: Text('No products found'));
                  } else {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Thêm padding xung quanh GridView
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio:
                              0.7, // Điều chỉnh tỷ lệ khung hình nếu cần thiết
                          children: productViewModel.products.map((product) {
                            return Padding(
                              padding: const EdgeInsets.all(
                                  8.0), // Thêm padding giữa các mục trong grid
                              child: ProductCard(product: product),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        }
      },
    );
  }
}
