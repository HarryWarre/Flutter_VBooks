import 'package:flutter/material.dart';

import '../../data/model/productmodel.dart';

class ProductListTile extends StatelessWidget {
  final Product product;
  final int quantity;

  ProductListTile({required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        'assets/images/product/${product.img}',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error);
        },
        width: 50,
        height: 50,
      ),
      title: Text(product.name!),
      trailing: Text('x $quantity'),
    );
  }
}
