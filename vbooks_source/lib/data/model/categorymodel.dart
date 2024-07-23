import 'package:vbooks_source/data/model/productmodel.dart';

class Category {
  String? id;
  String? name;
  String? img;
  List<Product>? products; // Cập nhật kiểu dữ liệu cho danh sách sản phẩm

  // Constructor
  Category({this.id, this.name, this.img, this.products});

  // Phương thức tạo đối tượng từ JSON
  Category.fromJson(Map<String, dynamic> json) {
    id = json['_id']; // Chú ý: '_id' trong JSON
    name = json['name'];
    img = json['img'];
    // Chuyển đổi danh sách sản phẩm nếu có
    if (json['products'] != null) {
      products =
          (json['products'] as List).map((i) => Product.fromJson(i)).toList();
    }
  }

  // Phương thức chuyển đổi đối tượng thành JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id; // Chú ý: '_id' trong JSON
    data['name'] = name;
    data['img'] = img;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
