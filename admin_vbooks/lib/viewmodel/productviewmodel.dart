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

  Future<void> addProduct(String name, int price, String img, String desc, String catId, String publisherId) async {
    isLoading = true;
    notifyListeners();

    try {
        await productService.addProduct(
        name: name, price: price, 
        img: img, desc: desc, 
        catId: catId,
        publisherId: publisherId
        );

    } catch (error) {
      print('Error creating product: $error');

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProduct(String id,String name, int price, String img, String desc, String catId, String publisherId) async {
    isLoading = true;
    notifyListeners();

    try {
      await productService.updateProduct(
        id: id,
        name: name, price: price, 
        img: img, desc: desc, 
        catId: catId, 
        publisherId: publisherId
        );
        
    } catch (error) {
      print('Error creating product: $error');

    } finally {
      isLoading = false;
      notifyListeners();
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
