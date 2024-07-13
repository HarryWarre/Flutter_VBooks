import 'package:flutter/material.dart';

import '../../data/model/productmodel.dart';
import '../../data/model/typelistmodel.dart';
import '../../data/provider/productprovider.dart';
import '../../data/provider/typeproductslist.dart';
import 'productcard.dart';

class TypeList extends StatelessWidget {
  final String title;
  final String type;
  final TypeListProvider typeListProvider = TypeListProvider();
  final ReadData productProvider = ReadData();

  TypeList({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder<TypeListResponse>(
        future: typeListProvider.getTypelistData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<String> productIds;

            if (type == 'feartured') {
              productIds = snapshot.data!.feartured;
            } else if (type == 'hot') {
              productIds = snapshot.data!.hot;
            } else {
              return const Center(child: Text('Invalid type'));
            }

            return FutureBuilder<List<Product>>(
              future: Future.wait(productIds
                  .map((id) => productProvider.getProductById(id))
                  .toList()),
              builder: (context, productSnapshot) {
                if (productSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (productSnapshot.hasError) {
                  return Center(child: Text('Error: ${productSnapshot.error}'));
                } else if (productSnapshot.hasData) {
                  final products = productSnapshot.data!;

                  return ListView.builder(
                    itemCount: (products.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      final productPage =
                          products.skip(index * 2).take(2).toList();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(2, (colIndex) {
                          if (colIndex < productPage.length) {
                            return Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    ProductCard(product: productPage[colIndex]),
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
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
