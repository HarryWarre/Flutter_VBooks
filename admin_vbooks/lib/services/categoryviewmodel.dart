import 'package:flutter/foundation.dart';
import '../data/model/category.dart';
import '../services/categoryservice.dart';

class CategoryViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<CategoryModel> categories = [];

  final CategoryService categoryService;

  CategoryViewModel(this.categoryService);

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      categories = await categoryService.fetchCategories();
      print('Fetched categories: ${categories.map((c) => c.name).toList()}'); // Log danh mục để kiểm tra
    } catch (error) {
      print('Error fetching categories: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
   Future<void> createCategory(CategoryModel category) async {
    isLoading = true;
    notifyListeners();

    try {
      await categoryService.createCategory(category);
      await fetchCategories(); // Refresh categories after creation
    } catch (error) {
      print('Error creating category: $error');
      // You can also add more sophisticated error handling here
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    isLoading = true;
    notifyListeners();

    try {
      await categoryService.updateCategory(category);
      await fetchCategories(); // Refresh categories after update
    } catch (error) {
      print('Error updating category: $error');
      // You can also add more sophisticated error handling here
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
    Future<void> deleteCategory(String id) async {
    isLoading = true;
    notifyListeners();

    try {
      await categoryService.deleteCategory(id); // Sử dụng categoryService để xóa danh mục
      await fetchCategories(); // Refresh categories after deletion
    } catch (error) {
      print('Error deleting category: $error');
      // Bạn có thể thêm xử lý lỗi tinh vi hơn ở đây nếu cần
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
