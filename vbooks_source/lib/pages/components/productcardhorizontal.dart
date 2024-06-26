import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import 'package:vbooks_source/conf/const.dart'; // Uncomment if necessary

import '../../data/model/productmodel.dart'; // Adjust the import path as needed

class HorizontalProductCard extends StatelessWidget {
  final Product product;
  const HorizontalProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Stack(
        children: [
          Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'asset/images/product/${product.img}',
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              // Product Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
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
          // Heart Icon
          Positioned(
            top: 8.0,
            right: 8.0,
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.grey[400],
              ),
              onPressed: () {
                // Handle favorite action
              },
            ),
          ),
        ],
      ),
    );
  }
}
