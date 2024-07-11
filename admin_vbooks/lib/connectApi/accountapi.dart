import 'dart:convert';
import 'package:admin_vbooks/config/const.dart';
import 'package:admin_vbooks/data/model/account.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchItem() async {
  final response = await http.get(Uri.parse('$serverUrl/account/'));

  if (response.statusCode == 200) {
    final itemList = jsonDecode(response.body);

    final items = itemList.map((item) {
      return Account.fromJson(item);
    }).toList();
    return items;
  } else {
    throw Exception("Failed to fetch item");
  }
}

Future<String> deleteAccount(String id) async {
  final response = await http.delete(Uri.parse('$serverUrl/account/delete/$id'));

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData['message'];
  } else if (response.statusCode == 404) {
    final responseData = jsonDecode(response.body);
    return responseData['message'];
  } else {
    throw Exception("Failed to delete account");
  }
}