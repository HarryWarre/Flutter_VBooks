class TypePayment {
  final String id;
  final String name;

  TypePayment({required this.id, required this.name});

  factory TypePayment.fromJson(Map<String, dynamic> json) {
    return TypePayment(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
