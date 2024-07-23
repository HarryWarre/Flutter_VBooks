import 'dart:convert';
import 'package:admin_vbooks/connectApi/apiservice.dart';
import 'package:admin_vbooks/data/model/category.dart';
import 'package:flutter/foundation.dart';


class CategoryService {
  final ApiService apiService;

  CategoryService(this.apiService);

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await apiService.get('category/getCategory'); // Cập nhật endpoint nếu cần
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
  Future<void> createCategory(CategoryModel category) async {

    var data = {
      'name': category.name,
      'category': category.desc
    };

    final response = await apiService.post(
      'category/createCategory',
      data
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create category');
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    var data = {
      'name': category.name,
      'category': category.desc
    };
    final response = await apiService.put(
      'category/updateCategory/${category.id}',
      data
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }
   Future<void> deleteCategory(String id) async {
    final response = await apiService.delete('category/deleteCategory/$id');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete category');
    }
  }
}
