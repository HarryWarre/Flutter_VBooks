import 'dart:convert';
import 'package:admin_vbooks/data/model/product.dart';
import 'package:flutter/material.dart';
import './apiservice.dart';

class ProductService {
  final ApiService apiService;

  ProductService(this.apiService);

  Future<List<Product_Model>> fetchProducts() async {
    final response = await apiService.get('product/getProduct');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse
          .map((product) => Product_Model.fromJson(product))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product_Model>> searchProducts(String keyword) async {
    final response = await apiService.get('product/search?keyword=$keyword');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product_Model.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }

  Future<List<Product_Model>> fetchProductsById(String productId) async {
    final response = await apiService.get('product/findbyid/$productId');

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Product_Model.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get Cart');
    }
  }

  Future<void> addProduct(
      {required String name,
      required dynamic price,
      required String img,
      required String desc,
      required String catId,
      required String publisherId}) async {
    var data = {
      'name': name,
      'price': price,
      'img': img,
      'desc': desc,
      'catId': catId,
      'publisherId': publisherId
    };

    final response = await apiService.post('product/createProduct', data);
    if (response.statusCode != 200) {
      throw Exception('Lỗi khi tạo sản phẩm');
    }
  }

  Future<void> updateProduct(
      {required String id,
      required String name,
      required dynamic price,
      required String img,
      required String desc,
      required String catId,
      required String publisherId}) async {
    var data = {
      'name': name,
      'price': price,
      'img': img,
      'desc': desc,
      'catId': catId,
      'publisherId': publisherId,
    };

    final response = await apiService.put('product/updateProduct/$id', data);
    if (response.statusCode != 200) {
      throw Exception(Text('Lỗi khi cập nhật sản phẩm'));
    }
  }

  Future<void> deleteProduct({required String id}) async {
    final response = await apiService.delete('product/deleteProduct/$id');

    if (response.statusCode != 200) {
      return;
    }
  }
}
