import 'dart:io'; // Import this package to handle file images
import 'package:admin_vbooks/config/const.dart';
import 'package:flutter/material.dart';
import '/../data/model/product.dart';
import '/../data/helper/db_helper.dart';
import 'product_add.dart';

class ProductBuilder extends StatefulWidget {
  final Function(List<int>) onSelectionChanged;

  const ProductBuilder({required this.onSelectionChanged, super.key});

  @override
  State<ProductBuilder> createState() => _ProductBuilderState();
}

class _ProductBuilderState extends State<ProductBuilder> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final List<int> _selectedProducts = [];

  Future<List<Product_Model>> _getProducts() async {
    // Thêm vào 1 dòng dữ liệu nếu getdata không có hoặc chưa có database
    return await _databaseHelper.products();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product_Model>>(
      future: _getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final itemCat = snapshot.data![index];
              return _buildProduct(itemCat, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildProduct(Product_Model product, BuildContext context) {
    return Card(
      child: ListTile(
        // Check box for delete products
        leading: Checkbox(
          checkColor: Colors.white,
          activeColor: primary,
          value: _selectedProducts.contains(product.id),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                _selectedProducts.add(product.id!);
              } else {
                _selectedProducts.remove(product.id);
              }
              widget.onSelectionChanged(_selectedProducts);
            });
          },
        ),
        title: Row(
          children: [
            if (product.img != null && product.img!.isNotEmpty)
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: FileImage(File(product.img!)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${product.price} đ',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: primary,
                    ),
                  ),
                  Text(
                    'S${product.id.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => ProductAdd(
                          isUpdate: true,
                          productmodel: product,
                        ),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
            ),
          ],
        ),
      ),
    );
  }
}
