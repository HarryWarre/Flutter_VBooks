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
  final TextEditingController _searchController = TextEditingController();
  List<Product_Model> _products = [];
  List<Product_Model> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);
    _loadProducts(); // Load products initially
  }

  Future<void> _loadProducts() async {
    _products = await _getProducts();
    _filteredProducts =
        _products; // Ensure filtered list initially matches all products
    setState(() {}); // Update UI with new data
  }

  Future<List<Product_Model>> _getProducts() async {
    return await _databaseHelper.products();
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _products.where((product) {
        return product.name!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Tìm kiếm sản phẩm',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: _buildProductList(),
        ),
      ],
    );
  }

  Widget _buildProductList() {
    return _filteredProducts.isEmpty
        ? const Center(child: Text('Không có sản phẩm nào'))
        : ListView.builder(
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              final itemCat = _filteredProducts[index];
              return _buildProduct(itemCat, context);
            },
          );
  }

  Widget _buildProduct(Product_Model product, BuildContext context) {
    return Card(
      child: ListTile(
        // Checkbox for selecting products
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
            // Display product information
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
                    .then(
                        (_) => _loadProducts()); // Reload products after update
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
