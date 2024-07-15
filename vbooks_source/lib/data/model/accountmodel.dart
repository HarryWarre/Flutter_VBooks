class Account {
  String? email;
  String? password;
  String? fullName;
  String? address;
  String? phoneNumber;
  String? bod;
  int? sex;

  Account(
      {this.email,
      this.password,
      this.fullName,
      this.address,
      this.phoneNumber,
      this.bod,
      this.sex});

  Account.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    fullName = json['fullName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    bod = json['bod'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['fullName'] = this.fullName;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['bod'] = this.bod;
    data['sex'] = this.sex;
    return data;
  }
}