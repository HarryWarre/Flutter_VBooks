class Product_Model {
  int? id;
  String? name;
  int? price;
  String? img;
  String? desc;
  int? catId;
  //constructor
  Product_Model(
      {this.id, this.name, this.price, this.img, this.desc, this.catId});
  Product_Model.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = json["price"];
    img = json["img"];
    desc = json["desc"];
    catId = json["catId"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["img"] = img;
    data["desc"] = desc;
    data["catId"] = catId;
    return data;
  }

  factory Product_Model.fromMap(Map<String, dynamic> map) {
    return Product_Model(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      desc: map['desc'] ?? '',
      img: map['img'] ?? '',
      catId: map['catId'],
    );
  }
}
