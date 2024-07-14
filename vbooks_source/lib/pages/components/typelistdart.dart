import 'package:flutter/material.dart';

import '../../data/model/productmodel.dart';
import '../../data/provider/productprovider.dart';
import '../../services/productservice.dart';
import 'productcard.dart';

class TypeList extends StatelessWidget {
  final String title;
  final ProductService productService;

  TypeList({super.key, required this.title, required this.productService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: productService.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final products = snapshot.data!;

            return ListView.builder(
              itemCount: (products.length / 2).ceil(),
              itemBuilder: (context, index) {
                final productPage = products.skip(index * 2).take(2).toList();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(2, (colIndex) {
                    if (colIndex < productPage.length) {
                      return Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductCard(product: productPage[colIndex]),
                        ),
                      );
                    } else {
                      return const Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(),
                        ),
                      );
                    }
                  }),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
