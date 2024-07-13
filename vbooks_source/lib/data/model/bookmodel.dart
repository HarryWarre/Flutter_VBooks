class Book {
  String? id;
  String? name;
  int? price;
  String? img;
  String? des;
  String? catId;

  Book({this.id, this.name, this.price, this.img, this.des, this.catId});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    des = json['des'];
    catId = json['catId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['img'] = this.img;
    data['des'] = this.des;
    data['catId'] = this.catId;
    return data;
  }
}
