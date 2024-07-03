import 'package:admin_vbooks/pages/productmanagement/productmanagement.dart';
import 'package:flutter/material.dart';
import '../../../components/confirmdeletedialog.dart';
import '../../../components/uploadfile.dart';
import '../../../config/const.dart';
import '../../../data/helper/db_helper.dart';
import 'category_add.dart';
import 'category_data.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final List<int> _selectedCategories = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _deleteSelectedCategories() async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          title: 'Chú ý',
          content: 'Bạn đang xóa dữ liệu. Cân nhắc trước khi xóa!',
          onConfirm: () {},
        );
      },
    );

    if (confirm == true) {
      setState(() {
        for (var id in _selectedCategories) {
          _databaseHelper.deleteCategory(id);
        }
        _selectedCategories.clear();
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CategoryList(), // Navigate back to ProductBuilder
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh mục"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press here
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ProductManagement(), // Navigate back to ProductBuilder
              ),
            );
          },
        ),
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
                            builder: (_) => const CategoryAdd(),
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
                        'Thêm danh mục',
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
                      borderRadius: BorderRadius.circular(12),
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
                  onPressed: _deleteSelectedCategories,
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
            child: CategoryBuilder(
              onSelectionChanged: (selectedProducts) {
                setState(() {
                  _selectedCategories.clear();
                  _selectedCategories.addAll(selectedProducts);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
