import 'package:admin_vbooks/viewmodel/categoryviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/confirmdeletedialog.dart';
import '../../../components/uploadfile.dart';
import '../../../config/const.dart';
import 'category_add.dart';
import 'package:admin_vbooks/pages/productmanagement/productmanagement.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final List<int> _selectedCategories = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CategoryViewModel>().fetchCategories());
  }

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
      final categoryViewModel = context.read<CategoryViewModel>();
      for (var id in _selectedCategories) {
        await categoryViewModel
            .deleteCategory(id.toString()); // Chuyển đổi id thành String
      }
      setState(() {
        _selectedCategories.clear();
      });
      context
          .read<CategoryViewModel>()
          .fetchCategories(); // Cập nhật danh sách danh mục
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const ProductManagement(), // Navigate back to ProductManagement
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
                        .then((_) => context
                            .read<CategoryViewModel>()
                            .fetchCategories());
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
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: _deleteSelectedCategories,
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
            child: Consumer<CategoryViewModel>(
              builder: (context, categoryViewModel, child) {
                if (categoryViewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (categoryViewModel.categories.isEmpty) {
                  return const Center(
                      child: Text('Không thấy danh mục sản phẩm'));
                } else {
                  return ListView.builder(
                    itemCount: categoryViewModel.categories.length,
                    itemBuilder: (context, index) {
                      final category = categoryViewModel.categories[index];
                      return ListTile(
                        title: Text(category.name),
                        leading: Checkbox(
                          value: category.id != null &&
                              _selectedCategories.contains(category.id!),
                          onChanged: (bool? selected) {
                            setState(() {
                              if (category.id != null) {
                                debugPrint(
                                    'Checkbox changed: ${category.id}, selected: $selected');
                                if (selected == true) {
                                  // Thêm vào danh sách nếu chưa có
                                  if (!_selectedCategories
                                      .contains(category.id!)) {
                                    _selectedCategories.add(category.id!);
                                  }
                                } else {
                                  // Xóa khỏi danh sách nếu có
                                  if (_selectedCategories
                                      .contains(category.id!)) {
                                    _selectedCategories.remove(category.id!);
                                  }
                                }
                                debugPrint(
                                    'Selected categories: $_selectedCategories');
                              }
                            });
                          },
                         
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}