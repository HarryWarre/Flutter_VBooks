import 'dart:io'; // Import this package to handle file images
import 'package:flutter/material.dart';
import '/../data/model/product.dart';
import '/../data/helper/db_helper.dart';
import 'product_add.dart';

class ProductBuilder extends StatefulWidget {
  const ProductBuilder({super.key});

  @override
  State<ProductBuilder> createState() => _ProductBuilderState();
}

class _ProductBuilderState extends State<ProductBuilder> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              alignment: Alignment.center,
              child: Text(
                product.id.toString(),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text('Description: ${product.desc!}'),
                  const SizedBox(height: 4.0),
                  Text('Price: \$${product.price!}'),
                  const SizedBox(height: 4.0),
                  Text('Category ID: ${product.catId!}'),
                ],
              ),
            ),
            if (product.img != null && product.img!.isNotEmpty)
              Container(
                height: 50.0,
                width: 50.0,
                margin: const EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: FileImage(File(product.img!)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            IconButton(
              onPressed: () {
                setState(() {
                  _databaseHelper.deleteProduct(product.id!);
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
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
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.yellow.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
