import 'package:flutter/material.dart';
import '../../../data/model/productmodel.dart';
import '../../../services/productservice.dart';
import '../productcard.dart';

class ProductSearchResults extends StatelessWidget {
  final String keyword;
  final ProductService productService;

  const ProductSearchResults(
      {super.key, required this.keyword, required this.productService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả tìm kiếm: $keyword'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productService.searchProducts(keyword),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              padding: const EdgeInsets.all(8.0),
              children: snapshot.data!.map((product) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCard(product: product),
                );
              }).toList(),
            );
          } else {
            return const Center(child: Text('Không tìm thấy sản phẩm nào'));
          }
        },
      ),
    );
  }
}
