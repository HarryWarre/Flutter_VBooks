import 'package:flutter/material.dart';
import '../components/productcard.dart';
import '../../data/model/typelistmodel.dart';
import '../../data/provider/typeproductslist.dart';
import '../../data/model/productmodel.dart';
import '../../data/provider/productprovider.dart';

class FeaturedListWidget extends StatelessWidget {
  final TypeListProvider typeListProvider = TypeListProvider();
  final ReadData productProvider = ReadData();

  FeaturedListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TypeListResponse>(
      future: typeListProvider.getTypelistData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final fearturedList = snapshot.data!.feartured;

          return FutureBuilder<List<Product>>(
            future: Future.wait(fearturedList
                .map((id) => productProvider.getProductById(id))
                .toList()),
            builder: (context, productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (productSnapshot.hasError) {
                return Center(child: Text('Error: ${productSnapshot.error}'));
              } else if (productSnapshot.hasData) {
                final products = productSnapshot.data!;

                return PageView.builder(
                  itemCount: (products.length / 2).ceil(),
                  itemBuilder: (context, pageIndex) {
                    final productPage =
                        products.skip(pageIndex * 2).take(2).toList();
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
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
