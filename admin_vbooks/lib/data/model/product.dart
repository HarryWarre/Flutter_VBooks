class Product_Model {
  String? id;
  String? name;
  int? price;
  String? img;
  String? desc;
  String? catId;
  String? publisherId;
  //constructor
  Product_Model(
      {this.id, this.name, this.price, this.img, this.desc, this.catId, this.publisherId});
  Product_Model.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    price = json["price"];
    img = json["img"];
    desc = json["desc"];
    catId = json["catId"];
    publisherId = json["publisherId"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["img"] = img;
    data["desc"] = desc;
    data["catId"] = catId;
    data["publisherId"] = publisherId;
    return data;
  }

  factory Product_Model.fromMap(Map<String, dynamic> map) {
    return Product_Model(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      desc: map['desc'] ?? '',
      img: map['img'] ?? '',
      catId: map['catId'] ?? '',
      publisherId: map['publisherId'] ?? '',
    );
  }
}
