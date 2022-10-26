class HomeModel{
  bool? status;
  String? message;
  Data? data;
  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Banners>? banners;
  List<Products>? products;
  List<Products>? bestSeller;
  List<Products>? exclusive;
  List<Products>?forYou;
  List<Products>?daily;
  String? ad;
  Data({this.banners, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      bestSeller = <Products>[];
      exclusive = <Products>[];
      forYou =<Products>[];
      json['products'].forEach((v){
        if(v['id']<57){
          bestSeller!.add(Products.fromJson(v));
        }else if(v['id']<83){
          exclusive!.add(Products.fromJson(v));
        }else if(v['id']<88){
          forYou!.add(Products.fromJson(v));
        }else{
          products!.add(Products.fromJson(v));
        }
      });
    }
    ad = json['ad'];
  }
}
class Banners {
  int? id;
  String? image;
  Banners({this.id, this.image});
  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products{
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Products(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description,
        this.images,
        this.inFavorites,
        this.inCart});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}