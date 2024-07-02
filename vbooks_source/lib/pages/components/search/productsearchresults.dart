// Trang kết quả tìm kiếm sản phẩm
import 'package:flutter/material.dart';

import '../../../data/model/productmodel.dart';
import '../../../data/provider/productprovider.dart';
import '../productcard.dart';

/*
  Trang trả về kết quả tìm kiếm, sử dụng provider getNameByKey để thực hiện trả về các sản phẩm theo keyword
 */
class ProductSearchResults extends StatelessWidget {
  final String keyword;

  const ProductSearchResults({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(keyword),
      ),
      body: FutureBuilder<List<Product>>(
        future: ReadData().getNameByKey(keyword),
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