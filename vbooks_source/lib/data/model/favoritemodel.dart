class FavoriteModel {
  String? sId;
  String? accountId;
  String? productId;

  FavoriteModel({this.sId, this.accountId, this.productId});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accountId = json['accountId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['accountId'] = this.accountId;
    data['productId'] = this.productId;
    return data;
  }
}
