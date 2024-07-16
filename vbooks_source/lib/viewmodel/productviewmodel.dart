import 'package:flutter/material.dart';
import '../data/model/productmodel.dart';
import '../services/apiservice.dart';
import '../services/productservice.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> products = [];
  bool isLoading = false;
  final ProductService productService;

  ProductViewModel() : productService = ProductService(ApiService());

  Future<void> fetchProductsByCategory(String categoryId) async {
    isLoading = true;
    notifyListeners(); // Thông báo listener

    try {
      // Hoãn một chút trước khi tải dữ liệu
      await Future.delayed(Duration(milliseconds: 100));
      products = await productService.fetchProductsByCategory(categoryId);
    } catch (e) {
      print('Error fetching products: $e');
      // Xử lý lỗi nếu cần thiết
    } finally {
      isLoading = false;
      notifyListeners(); // Thông báo listener sau khi hoàn thành
    }
  }

  Future<void> fetchProductsById(String productId) async {
    isLoading = true;
    // notifyListeners(); // Thông báo listener

    try {
      // Hoãn một chút trước khi tải dữ liệu
      await Future.delayed(Duration(milliseconds: 100));
      products = await productService.fetchProductsById(productId);
    } catch (e) {
      print('Error fetching products: $e');
      // Xử lý lỗi nếu cần thiết
    } finally {
      isLoading = false;
      notifyListeners(); // Thông báo listener sau khi hoàn thành
    }
  }

}
