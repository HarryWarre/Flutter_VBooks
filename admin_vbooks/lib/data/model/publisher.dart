class PublisherModel {
  String? id;
  String name;
  String email;
  String address;

  PublisherModel({this.id, required this.name, required this.email, required this.address});

  PublisherModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'] ?? '',
        email = json['email'] ?? '',
        address = json['address'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    return data;
  }

  @override
  String toString() => 'Publisher(id: $id, name: $name, email: $email, address: $address)';
}
