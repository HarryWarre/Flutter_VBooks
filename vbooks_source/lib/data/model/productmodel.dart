class Product {
  int? id;
  String? name;
  int? price;
  String? img;
  String? des;
  int? catId;

  //constructor
  Product({this.id, this.name, this.price, this.img, this.des, this.catId});
  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = json["price"];
    img = json["img"];
    des = json["des"];
    catId = json["catId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["img"] = img;
    data["des"] = des;
    data["catId"] = catId;
    return data;
  }
}