import 'package:admin_vbooks/data/model/category.dart';
import 'package:admin_vbooks/pages/productmanagement/category/category_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_vbooks/viewmodel/categoryviewmodel.dart';
import 'category_add.dart';
import 'package:admin_vbooks/pages/productmanagement/productmanagement.dart';
import '../../../components/confirmdeletedialog.dart';
import '../../../components/uploadfile.dart';
import '../../../config/const.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final List<String> _selectedCategories = [];
  late CategoryViewModel _categoryViewModel;
  List<CategoryModel> allCategory = [];

  void _handleSelectionChanged(List<String> selectedCategories) {
    setState(() {
      _selectedCategories.clear();
      _selectedCategories.addAll(selectedCategories);
    });
  }

  @override
  void initState() {
    super.initState();
    _categoryViewModel = context.read<CategoryViewModel>();
    _refreshCategories();
  }

  Future<void> _refreshCategories() async {
    await _categoryViewModel.fetchCategories();
    setState(() {
      allCategory = _categoryViewModel.categories;
    });
  }

  Future<void> _deleteSelectedCategories() async {
    if (_selectedCategories.isNotEmpty) {
      for (var category in _selectedCategories) {
        await _categoryViewModel.deleteCategory(category);
      }
      _selectedCategories.clear();
      await _refreshCategories(); // Refresh categories after deletion
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryList(), // Navigate back to ProductBuilder
      ),
    );
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProductManagement(),
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
                  onPressed: () async {
                    final result = await Navigator.of(context).push<bool>(
                      MaterialPageRoute(
                        builder: (_) => CategoryAdd(
                          isUpdate: false,
                          onSaveOrUpdate:
                              _refreshCategories, // Pass the callback
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CategoryList(), // Navigate back to ProductBuilder
                      ),
                    );
                    if (result == true) {
                      await _refreshCategories(); // Refresh the list after adding
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UploadPage(),
                      ),
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
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () async {
                    final bool confirmDelete = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmDeleteDialog(
                          title: 'Chú ý',
                          content:
                              'Bạn đang xóa dữ liệu. Cân nhắc trước khi xóa!',
                          onConfirm: () async {
                            await _deleteSelectedCategories();
                            Navigator.of(context).pop(true);
                          },
                        );
                      },
                    );

                    if (confirmDelete) {
                      await _deleteSelectedCategories(); // Refresh after deletion
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: danger,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
              onSelectionChanged: _handleSelectionChanged,
            ),
          ),
        ],
      ),
    );
  }
}
