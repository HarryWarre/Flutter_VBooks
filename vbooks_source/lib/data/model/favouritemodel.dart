import 'productmodel.dart'; // Đảm bảo bạn có import mô hình Product nếu cần

class Favorite {
  final String id;
  final String accountId;
  final String productId;

  Favorite(
      {required this.id, required this.accountId, required this.productId});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['_id'],
      accountId: json['accountId'],
      productId: json['productId'],
    );
  }
}
