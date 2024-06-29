import 'package:flutter/material.dart';

import 'product_add.dart';
import 'product_data.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // get list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sản phẩm"),
        centerTitle: true,
      ),
      body: const Center(child: ProductBuilder()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (_) => const ProductAdd(),
                  fullscreenDialog: true,
                ),
              )
              .then((_) => setState(() {}));
        },
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
    );
  }
}
