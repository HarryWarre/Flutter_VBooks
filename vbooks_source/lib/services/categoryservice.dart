import 'dart:convert';

import '../data/model/categorymodel.dart';
import 'apiservice.dart';

class CategoryService {
  final ApiService apiService;

  CategoryService(this.apiService);

  Future<List<Category>> fetchCategories() async {
    final response = await apiService.get('category/getCategory/');
    // print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Add other category-related methods if needed
}
