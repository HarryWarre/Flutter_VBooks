import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vbooks_source/data/model/productmodel.dart';
import 'package:vbooks_source/pages/components/button.dart';

Widget buildCartItem(
    Product product,  String imagePath,int quantity, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 140,
          width: 335,
          padding: const EdgeInsets.fromLTRB(10, 8, 12, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  imagePath,
                  width: 120,
                  height: 120,
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
                          overflow: TextOverflow.ellipsis, fontSize: 16,),
                    ),
                    Text(
                      '${NumberFormat('###,###,###').format(product.price! * quantity)} Đ',
                      style: const TextStyle(color: Colors.teal, fontSize: 16,),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Số lượng: ' + quantity.toString(),
                      style: const TextStyle(color: Colors.teal, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: IconButton(
                  icon: const Icon(CupertinoIcons.delete),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }