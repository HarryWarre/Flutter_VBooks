import 'package:vbooks_source/data/model/productmodel.dart';

class Category {
  String? id;
  String? name;
  String? img;
  //Constructor
  Category({this.id, this.name, this.img, required List products});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  List<Product>? get products => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
