import '../model/productmodel.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ReadData {
  static Future<List<Product>> loadData() async {
    var data = await rootBundle.loadString("assets/json/productlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List).map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> loadDatabyCat(int catId) async {
    var data = await rootBundle.loadString("assets/json/productlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List)
        .map((e) => Product.fromJson(e))
        .where((e) => e.catId == catId)
        .toList();
  }

  Future<Product> getProductById(int id) async {
    var data = await rootBundle.loadString("assets/json/productlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List)
        .map((e) => Product.fromJson(e))
        .firstWhere((product) => product.id == id);
  }

  Future<List<Product>> searchProducts(String pattern) async {
    var data = await rootBundle.loadString("assets/json/productlist.json");
    var dataJson = jsonDecode(data);

    List<Product> products = (dataJson["data"] as List)
        .map((e) => Product.fromJson(e))
        .where((product) =>
            product.name!.toLowerCase().contains(pattern.toLowerCase()))
        .take(5) // Giới hạn chỉ lấy top 5 kết quả
        .toList();

    return products;
  }

  Future<List<Product>> getNameByKey(String keyword) async {
    var data = await rootBundle.loadString("assets/json/productlist.json");
    var dataJson = jsonDecode(data);
    List<Product> products = (dataJson["data"] as List)
        .map((e) => Product.fromJson(e))
        .where((product) =>
            product.name!.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    return products;
  }
}