import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/typelistmodel.dart';

class TypeListProvider {
  Future<TypeListResponse> getTypelistData() async {
    final jsonString = await rootBundle.loadString('asset/json/typelists.json');
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

    return TypeListResponse.fromJson(jsonData);
  }
}
