import '../model/categorymodel.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ReadData {
  Future<List<Category>> loadData() async {
    var data = await rootBundle.loadString("assets/json/categorylist.json");
    var dataJson = jsonDecode(data);

    return (dataJson['data'] as List).map((e) => Category.fromJson(e)).toList();
  }
}
