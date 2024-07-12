import 'package:flutter/material.dart';

import '../data/model/categorymodel.dart';
import '../services/apiservice.dart';
import '../services/categoryservice.dart';

class CategoryViewModel extends ChangeNotifier {
  List<Category> categories = [];
  bool isLoading = false;
  final CategoryService categoryService;

  CategoryViewModel() : categoryService = CategoryService(ApiService());

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      categories = await categoryService.fetchCategories();
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
