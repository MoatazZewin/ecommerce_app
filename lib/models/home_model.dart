class HomeModel {
  late bool status;
  late HomeDataModel data;
  HomeModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.formJson(json['data']);
  }
}

class HomeDataModel {
  late List<BannerModel> banners = [];
  late List<ProductModel> products = [];
  HomeDataModel.formJson(Map<String, dynamic> json) {
    json['banners'].forEach((value) {
      banners.add(BannerModel.fromJson(value));
    });
    json['products'].forEach((value) {
      products.add(ProductModel.fromJson(value));
    });
  }
}

class BannerModel {
  late int id;
  late String image;
  BannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
