import 'dart:convert';
import 'package:vbooks_source/data/model/cartmodel.dart';
import 'apiservice.dart';
import 'package:http/http.dart' as http;

class CartService {
  final ApiService apiService;

  CartService(this.apiService);

  Future<List<Cart>> fetchCartsByAccountId(String accountId) async {
    final response = await apiService.get('cart/$accountId');
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> data = jsonResponse['carts'];
      return data.map((json) => Cart.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  
  Future<http.Response> addProductToCart(String productId, String accountId, int quantity) async{
    var data = {
      'productId': productId,
      'accountId': accountId,
      'quantity': quantity,
    };

    return await apiService.post('cart/add', data);
    
  }

}
