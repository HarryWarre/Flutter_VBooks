import 'dart:convert';
import '../data/model/productmodel.dart';
import './apiservice.dart';

class ProductService {
  final ApiService apiService;

  ProductService(this.apiService);

  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    final response = await apiService.get('product/findByCatId/$categoryId');

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final response = await apiService.get('product/getProduct');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> searchProducts(String keyword) async {
    final response = await apiService.get('product/search?keyword=$keyword');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }

  Future<List<Product>> fetchProductsById(String productId) async {
    final response = await apiService.get('product/findbyid/$productId');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get Cart');
    }
  }

  Future<Product> fetchProductById(String productId) async {
    final response = await apiService.get('product/findbyid/$productId');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to get product');
    }
  }
}
