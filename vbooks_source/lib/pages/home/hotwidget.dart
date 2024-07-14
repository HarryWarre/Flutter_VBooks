import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/productservice.dart';
import '../components/productcardhorizontal.dart';
import '../../data/model/productmodel.dart';
import '../../data/provider/productprovider.dart';
import '../../data/provider/typeproductslist.dart';

class HotProductList extends StatelessWidget {
  final TypeListProvider typeListProvider = TypeListProvider();
  final ReadData productProvider = ReadData();
  final ProductService productService;
  HotProductList({super.key, required this.productService});

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

          return Column(
            children: products.map((product) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: HorizontalProductCard(product: product),
              );
            }).toList(),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
