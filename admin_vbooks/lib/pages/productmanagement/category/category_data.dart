import 'package:flutter/material.dart';
import '../../../config/const.dart';
import '/../data/model/category.dart';
import '/../data/helper/db_helper.dart';
import 'category_add.dart';

class CategoryBuilder extends StatefulWidget {
  final Function(List<int>) onSelectionChanged;

  const CategoryBuilder({required this.onSelectionChanged, super.key});

  @override
  State<CategoryBuilder> createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final List<int> _selectedCategories = [];

  Future<List<CategoryModel>> _getCategories() async {
    // thêm vào 1 dòng dữ liệu nếu getdata không có hoặc chưa có database
    return await _databaseHelper.categories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: _getCategories(),
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
              return _buildCategory(itemCat, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildCategory(CategoryModel category, BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          checkColor: Colors.white,
          activeColor: primary,
          value: _selectedCategories.contains(category.id),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                _selectedCategories.add(category.id!);
              } else {
                _selectedCategories.remove(category.id);
              }
              widget.onSelectionChanged(_selectedCategories);
            });
          },
        ),
        title: Row(
          children: [
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'S${category.id.toString().padLeft(2, '0')}',
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
                        builder: (_) => CategoryAdd(
                          isUpdate: true,
                          categoryModel: category,
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
