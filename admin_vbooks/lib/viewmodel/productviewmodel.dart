import 'package:admin_vbooks/connectApi/apiservice.dart';
import 'package:admin_vbooks/connectApi/productservice.dart';
import 'package:admin_vbooks/data/model/product.dart';
import 'package:flutter/material.dart';


class ProductViewModel extends ChangeNotifier {
  List<Product_Model> products = [];
  bool isLoading = false;
  final ProductService productService;

  ProductViewModel() : productService = ProductService(ApiService());

  
  Future<void> fetchProduct() async {
    isLoading = true;

    try {
      // Hoãn một chút trước khi tải dữ liệu
      await Future.delayed(Duration(milliseconds: 100));
      products = await productService.fetchProducts();
    } catch (e) {
      print('Error fetching products: $e');
      // Xử lý lỗi nếu cần thiết
    } finally {
      isLoading = false;
      notifyListeners(); // Thông báo listener sau khi hoàn thành
    }
  }

  Future<void> deleteProduct(String id) async {
    notifyListeners();
    try{
      await Future.delayed(Duration(milliseconds: 100));
      productService.deleteProduct(id: id);
    }catch (e){
      print(e);
    } finally {
      notifyListeners();
    }
    

  }

}
