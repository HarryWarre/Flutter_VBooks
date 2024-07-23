import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/model/productmodel.dart';
import 'apiservice.dart';

class FavoriteService {
  final ApiService apiService;

  FavoriteService(this.apiService);

  Future<List<Product>> fetchFavorites(String accountId) async {
    final response = await apiService.get('favorite/$accountId');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      // Log toàn bộ dữ liệu phản hồi
      print('Response data: $data');

      if (data.containsKey('favorites') && data['favorites'] is List) {
        List<dynamic> favoritesJson = data['favorites'];

        // Log danh sách yêu thích JSON
        print('Favorites JSON: $favoritesJson');

        List<Product> favoriteProducts = [];
        for (var favorite in favoritesJson) {
          String productId = favorite['productId'];
          // Fetch product details for each favorite item
          Product product = await fetchProductById(productId);
          favoriteProducts.add(product);
        }

        // Log danh sách sản phẩm yêu thích
        print('Favorite products: $favoriteProducts');

        return favoriteProducts;
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  Future<Product> fetchProductById(String productId) async {
    final response = await apiService.get('product/findbyid/$productId');
    if (response.statusCode == 200) {
      List<dynamic> data =
          jsonDecode(response.body); // Chuyển đổi thành danh sách
      if (data.isNotEmpty) {
        return Product.fromJson(data.first);
      } else {
        throw Exception('Product not found');
      }
    } else {
      throw Exception('Failed to get product');
    }
  }

  Future<void> deleteFavorite(String accountId, String productId) async {
    final response = await apiService.deleteWithBody(
      'favorite/deleteFavorite',
      body: jsonEncode({
        'accountId': accountId,
        'productId': productId,
      }),
    );

    if (response.statusCode == 200) {
      // Thành công: Không cần trả về dữ liệu gì cả
      return;
    } else {
      // Xử lý lỗi: Ném ngoại lệ với thông báo lỗi
      throw Exception('Failed to delete favorite');
    }
  }
}
