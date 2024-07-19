import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vbooks_source/data/model/productmodel.dart';
import 'package:vbooks_source/pages/components/button.dart';

Widget buildCartItem(Product product, String imagePath, int quantity,
    VoidCallback onIncrease, VoidCallback onDecrease, VoidCallback onRemove) {
  print('IMG: ${product.img}');
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onRemove,
      child: Container(
        height: 140,
        width: 335,
        padding: const EdgeInsets.fromLTRB(10, 8, 12, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Image.network(
                "https://vnibooks.com/wp-content/uploads/2021/09/giao-di%CC%A3ch-forex.jpeg",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${NumberFormat('###,###,###').format(product.price! * quantity)} Đ',
                    style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(CupertinoIcons.minus),
                        onPressed: onDecrease,
                      ),
                      Text(
                        quantity.toString(),
                        style:
                            const TextStyle(color: Colors.teal, fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(CupertinoIcons.plus),
                        onPressed: onIncrease,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: IconButton(
                icon: const Icon(CupertinoIcons.delete),
                onPressed: onRemove,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
