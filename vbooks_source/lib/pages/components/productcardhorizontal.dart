import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vbooks_source/conf/const.dart';

import '../../data/model/productmodel.dart'; // Adjust the import path as needed

class HorizontalProductCard extends StatefulWidget {
  final Product product;
  const HorizontalProductCard({Key? key, required this.product})
      : super(key: key);

  @override
  _HorizontalProductCardState createState() => _HorizontalProductCardState();
}

class _HorizontalProductCardState extends State<HorizontalProductCard> {
  bool _isFavorite = false;

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
                  'assets/images/product/${widget.product.img}',
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
                      widget.product.name!,
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
                      '${NumberFormat('###,###,###').format(widget.product.price!)} Đ',
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
                Icons.favorite,
                color: _isFavorite ? primaryColor : Colors.grey[400],
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
