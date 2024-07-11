class Admin {
  String? id;
  String? email;
  String? password;
  int? role;

  Admin({this.id, this.email, this.password, this.role});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    return data;
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['_id']?.toInt() ?? 0,
      email: map['email']?.toString() ?? '',
      password: map['password']?.toString() ?? '',
      role: map['role']?.toInt() ?? '1',
    );
  }
}