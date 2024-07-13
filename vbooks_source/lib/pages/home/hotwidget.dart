import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/productcardhorizontal.dart';
import '../../data/model/productmodel.dart';
import '../../data/provider/productprovider.dart';
import '../../data/provider/typeproductslist.dart';

class HotProductList extends StatefulWidget {
  const HotProductList({super.key});

  @override
  _HotProductListState createState() => _HotProductListState();
}

class _HotProductListState extends State<HotProductList> {
  late Future<List<Product>> _hotProductsFuture;

  @override
  void initState() {
    super.initState();
    _hotProductsFuture = _fetchHotProducts();
  }

  Future<List<Product>> _fetchHotProducts() async {
    final typeListProvider = TypeListProvider();
    final typeListResponse = await typeListProvider.getTypelistData();
    final hotProductIds = typeListResponse.hot;

    final readData = ReadData();
    List<Product> hotProducts = [];
    for (String id in hotProductIds) {
      Product product = await readData.getProductById(id);
      hotProducts.add(product);
    }

    return hotProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: _hotProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hot products available'));
          } else {
            List<Product> hotProducts = snapshot.data!;
            return ListView.builder(
              itemCount: hotProducts.length,
              itemBuilder: (context, index) {
                return HorizontalProductCard(product: hotProducts[index]);
              },
            );
          }
        },
      ),
    );
  }
}
