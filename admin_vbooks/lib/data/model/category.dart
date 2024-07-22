import 'dart:convert';

class CategoryModel {
  final String? id;
  final String name;
  final String desc;

  CategoryModel({
    this.id,
    required this.name,
    required this.desc,
  });

  // Convert a CategoryModel into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] != null ? (map['id'] as int) : null,
      name: map['name'] ?? '',  // Cung cấp giá trị mặc định nếu 'name' là null
      desc: map['desc'] ?? '',  // Cung cấp giá trị mặc định nếu 'desc' là null
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] != null ? (json['id'] as int) : null,
      name: json['name'] ?? '',  // Cung cấp giá trị mặc định nếu 'name' là null
      desc: json['desc'] ?? '',  // Cung cấp giá trị mặc định nếu 'desc' là null
    );
  }

  @override
  String toString() => 'Category(id: $id, name: $name, desc: $desc)';
}
