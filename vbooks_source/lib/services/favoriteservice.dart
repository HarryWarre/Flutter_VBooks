import 'dart:convert';
import 'package:vbooks_source/data/model/cartmodel.dart';
import 'package:vbooks_source/data/model/favoritemodel.dart';
import 'apiservice.dart';
import 'package:http/http.dart' as http;

class FavoriteService {
  final ApiService apiService;

  FavoriteService(this.apiService);

  Future<List<FavoriteModel>> fetchVaroriteById(String accountId) async {
    final response = await apiService.get('favorite/$accountId');
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> data = jsonResponse['carts'];
      return data.map((json) => FavoriteModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  Future<void> deleteFavorite(String accountId, String productId) async {
    final response = await apiService.delete('favorite/deleteFavorite/$accountId/$productId');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete favorite product');
    }
  }

  Future<void> addFavorite(
      String accountId, String productId) async {
    final response = await apiService.post(
      'favorite/addFavorite',
      {
        'accountId': accountId,
        'productId': productId,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add favorite to account');
    }
  }

  Future<bool> isFavorite(String accountId, String productId) async {
    final response = await apiService.get('favorite/isFavorite/$accountId/$productId');
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['isFavorite'];
    } else {
      throw Exception('Failed to check favorite status');
    }
  }
}
