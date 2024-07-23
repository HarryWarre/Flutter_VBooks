import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_vbooks/viewmodel/categoryviewmodel.dart';
import 'package:admin_vbooks/data/model/category.dart';
import 'category_add.dart'; // Đảm bảo bạn có import đúng tệp CategoryAdd

class CategoryBuilder extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;

  const CategoryBuilder({required this.onSelectionChanged, Key? key}) : super(key: key);

  @override
  _CategoryBuilderState createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  List<String> _selectedCategory = [];
  final TextEditingController _searchController = TextEditingController();
  List<CategoryModel> _categories = [];
  List<CategoryModel> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCategories);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCategories();
    });
  }

  Future<void> _loadCategories() async {
    final categoryViewModel = context.read<CategoryViewModel>();
    await categoryViewModel.fetchCategories();
    setState(() {
      _categories = categoryViewModel.categories;
      _filteredCategories = _categories;
    });
  }

  void _filterCategories() {
    setState(() {
      _filteredCategories = _categories.where((category) {
        return category.name.toLowerCase().contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, categoryViewModel, child) {
        if (categoryViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (_filteredCategories.isEmpty) {
          return const Center(child: Text('Không có danh mục nào'));
        } else {
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
                child: ListView.separated(
                  itemCount: _filteredCategories.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final category = _filteredCategories[index];
                    return ListTile(
                      leading: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).primaryColor,
                        value: _selectedCategory.contains(category.id ?? ''),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              if (!_selectedCategory.contains(category.id ?? '')) {
                                _selectedCategory.add(category.id ?? '');
                              }
                            } else {
                              _selectedCategory.remove(category.id ?? '');
                            }
                            widget.onSelectionChanged(_selectedCategory);
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
                                  category.name,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
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
                                        onSaveOrUpdate: _loadCategories,
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  )
                                  .then((_) => _loadCategories());
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
