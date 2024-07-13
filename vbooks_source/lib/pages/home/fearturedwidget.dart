import 'package:flutter/material.dart';
import '../components/productcard.dart';
import '../../data/model/typelistmodel.dart';
import '../../data/provider/typeproductslist.dart';
import '../../data/model/productmodel.dart';
import '../../data/provider/productprovider.dart';
import '../../services/productservice.dart';

class FeaturedListWidget extends StatelessWidget {
  final TypeListProvider typeListProvider = TypeListProvider();
  final ReadData productProvider = ReadData();
  final ProductService productService;
  FeaturedListWidget({super.key, required this.productService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productService.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final products = snapshot.data!;

          return PageView.builder(
            itemCount: (products.length / 2).ceil(),
            itemBuilder: (context, pageIndex) {
              final productPage = products.skip(pageIndex * 2).take(2).toList();
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: productPage.map((product) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCard(product: product),
                    ),
                  );
                }).toList(),
              );
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
