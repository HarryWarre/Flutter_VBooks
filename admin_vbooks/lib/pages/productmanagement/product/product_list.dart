import 'package:admin_vbooks/components/uploadfile.dart';
import 'package:admin_vbooks/config/const.dart';
import 'package:flutter/material.dart';
import '../../../components/confirmdeletedialog.dart';
import '../../../data/helper/db_helper.dart';
import 'product_add.dart';
import 'product_data.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<int> _selectedProducts = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _deleteSelectedProducts() {
    setState(() {
      if (_selectedProducts.isNotEmpty) {
        for (var id in _selectedProducts) {
          _databaseHelper.deleteProduct(id);
        }
        _selectedProducts.clear();
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductList(), // Navigate back to ProductBuilder
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sản phẩm"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bo tròn 16px
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Thêm sản phẩm',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Thêm hành động cho nút 2
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: peace,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bo tròn 16px
                    ),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Tải lên',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final bool confirmDelete = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Customize title and content based on context
                        const String deleteTitle = 'Chú ý'; // Example
                        const String deleteContent =
                            'Bạn đang xóa dữ liệu. Cân nhắc trước khi xóa!'; // Example
                        return ConfirmDeleteDialog(
                          title: deleteTitle,
                          content: deleteContent,
                          onConfirm: () =>
                              _deleteSelectedProducts(), // Call your delete function directly
                        );
                      },
                    );

                    if (confirmDelete) {
                      _deleteSelectedProducts();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: danger,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bo tròn 16px
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Xóa',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ProductBuilder(
              onSelectionChanged: (selectedProducts) {
                setState(() {
                  _selectedProducts.clear();
                  _selectedProducts.addAll(selectedProducts);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
