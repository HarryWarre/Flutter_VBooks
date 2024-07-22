import 'package:flutter/material.dart';
import '../../../config/const.dart';
import '/../data/model/category.dart';
import '/../data/helper/db_helper.dart';
import 'category_add.dart';

class CategoryBuilder extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;

  const CategoryBuilder({required this.onSelectionChanged, super.key});

  @override
  State<CategoryBuilder> createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final List<String> _selectedCategories = [];
  final TextEditingController _searchController = TextEditingController();
  List<CategoryModel> _categories = [];
  List<CategoryModel> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCategories);
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    List<CategoryModel> categories = await _getCategories();
    setState(() {
      _categories = categories;
      _filteredCategories = categories;
    });
  }

  Future<List<CategoryModel>> _getCategories() async {
    return await _databaseHelper.categories();
  }

  void _filterCategories() {
    setState(() {
      _filteredCategories = _categories.where((category) {
        return category.name!
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
              labelText: 'Tìm kiếm danh mục',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: _buildCategoryList(),
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    return _filteredCategories.isEmpty
        ? const Center(child: Text('Không có danh mục nào'))
        : ListView.builder(
            itemCount: _filteredCategories.length,
            itemBuilder: (context, index) {
              final itemCat = _filteredCategories[index];
              return _buildCategory(itemCat, context);
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
                    .then((_) => _loadCategories());
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
