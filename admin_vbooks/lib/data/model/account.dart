class Account {
  String? id;
  String? email;
  String? password;
  String? fullName;
  String? address;
  String? phoneNumber;
  String? dob;
  int? sex;

  Account(
      {this.id,
      this.email,
      this.password,
      this.fullName,
      this.address,
      this.phoneNumber,
      this.dob,
      this.sex});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    fullName = json['fullName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    dob = json['bod'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['fullName'] = this.fullName;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['bod'] = this.dob;
    data['sex'] = this.sex;
    return data;
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['_id'].toInt() ?? 0,
      email: map['email']?.toString() ?? '',
      password: map['password']?.toString() ?? '',
      fullName: map['fullName']?.toString() ?? '',
      address: map['address']?.toString() ?? '',
      sex: map['sex']?.toInt() ?? 1
    );
  }
}
