import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: unused_import
import 'package:vbooks_source/conf/const.dart';

import '../../data/model/productmodel.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Adjust to minimize the size
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 170,
              maxHeight: 170,
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.asset(
                'asset/images/product/${product.img}',
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${NumberFormat('###,###,###').format(product.price!)} Đ',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(21, 139, 125, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
