import '../model/productmodel.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ReadData {
  Future<List<Product>> loadData() async {
    var data = await rootBundle.loadString("asset/json/productlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List).map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> loadDatabyCat(int catId) async {
    var data = await rootBundle.loadString("asset/json/productlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List)
        .map((e) => Product.fromJson(e))
        .where((e) => e.catId == catId)
        .toList();
  }

  Future<Product> getProductById(int id) async {
    var data = await rootBundle.loadString("asset/json/productlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List)
        .map((e) => Product.fromJson(e))
        .firstWhere((product) => product.id == id);
  }
}
