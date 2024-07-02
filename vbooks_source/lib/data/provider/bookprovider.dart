import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vbooks_source/data/model/bookModel.dart';

class ReadData with ChangeNotifier{
   static Future<List<Book>> loadData() async{
    var data = await rootBundle.loadString("assets/json/book.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List).map((e) => Book.fromJson(e)).toList();
  }
  
   
}


