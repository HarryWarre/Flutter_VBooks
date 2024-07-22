import 'package:admin_vbooks/services/categoryviewmodel.dart';
import 'package:flutter/material.dart';
import '/../data/model/category.dart';
import '/../services/categoryservice.dart'; // Thêm import cho CategoryService
import 'package:provider/provider.dart';
import 'package:admin_vbooks/services/categoryviewmodel.dart'; // Import CategoryViewModel

class CategoryAdd extends StatefulWidget {
  final bool isUpdate;
  final CategoryModel? categoryModel;
  const CategoryAdd({super.key, this.isUpdate = false, this.categoryModel});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String titleText = "";

  @override
  void initState() {
    super.initState();
    if (widget.categoryModel != null && widget.isUpdate) {
      _nameController.text = widget.categoryModel!.name;
      _descController.text = widget.categoryModel!.desc;
    }
    titleText = widget.isUpdate ? "Cập nhật danh mục" : "Thêm danh mục";
  }

  Future<void> _onSave() async {
    final name = _nameController.text;
    final description = _descController.text;

    try {
      // Lấy instance của CategoryViewModel từ context
      final categoryViewModel = context.read<CategoryViewModel>();
      await categoryViewModel.createCategory(
        CategoryModel(name: name, desc: description)
      );
      // Điều hướng trở lại danh sách danh mục
      Navigator.pop(context);
    } catch (error) {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create category: $error'))
      );
    }
  }

  Future<void> _onUpdate() async {
    final name = _nameController.text;
    final description = _descController.text;

    try {
      // Lấy instance của CategoryViewModel từ context
      final categoryViewModel = context.read<CategoryViewModel>();
      await categoryViewModel.updateCategory(
        CategoryModel(name: name, desc: description, id: widget.categoryModel!.id)
      );
      // Điều hướng trở lại danh sách danh mục
      Navigator.pop(context);
    } catch (error) {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update category: $error'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Thêm tên danh mục',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descController,
              maxLines: 7,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Thêm mô tả',
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: () {
                  widget.isUpdate ? _onUpdate() : _onSave();
                },
                child: const Text(
                  'Lưu',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
