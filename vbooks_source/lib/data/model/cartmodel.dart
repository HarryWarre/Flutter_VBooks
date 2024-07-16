class Cart {
  String? id;
  String? accountId;
  String? productId;
  int? quantity;


  Cart({this.id, this.accountId, this.productId, this.quantity});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    accountId = json['accountId'];
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['accountId'] = this.accountId;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}
